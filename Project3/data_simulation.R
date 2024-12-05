# Setup ---------------------------------------------------------------
library(readr)
library(tidyverse)
library(knitr)
library(tidyr)   
library(dplyr)    
library(car)
library(ggpubr)
library(lme4) # For lmer
library(progress) # To track simulation progress

set.seed(2550)

# Configuration
alpha <- 5  
beta_values <- c(1, 2, 3) # Small/medium/large treatment effect
gamma2_values <- c(1, 10)    # Low/high between-cluster variance
sigma2_values <- c(1, 10)    # Low/high within-cluster variance
c1 <- 20           # Default cost of first sample in a cluster
c2 <- 10           # Default cost of additional samples
budget <- 2000     # Total budget
n_replications <- 100      # Number of replications for simulations

# Functions ------------------------------------------------------------

## Function to compute feasible cluster designs by cost ratio
compute_feasible_designs <- function(c1, c2, budget){
  designs <- expand.grid(
    n_clusters = seq(5, 15, by = 5), 
    R_per_cluster = seq(10, 50, by = 2)
  )
  
  designs <- designs %>%
    mutate(cost = n_clusters * (c1 + (R_per_cluster - 1) * c2)) %>%
    filter(cost <= budget) %>%
    group_by(n_clusters) %>%
    filter(cost == max(cost)) %>%
    ungroup()
  
  return(designs)
}


## Function to simulate data and estimate beta
simulate_and_evaluate <- function(n_clusters, R_per_cluster, 
                                         alpha, beta, gamma2, sigma2,
                                         distribution = "normal") {
  
  # Simulate X (Treatment assignment)
  X <- rbernoulli(n_clusters, 0.5)
  
  if (length(unique(X)) < 2) return(c(NA, NA, NA))  # Return NA if variability is insufficient
  
  # IF Normal (default)
  if (distribution == "normal"){
    
    # Simulate cluster level mean
    mu_i <- rnorm(n_clusters, 
                  mean = alpha + beta * X, 
                  sd = sqrt(gamma2))
    
    # Generate Normal outcomes
    Y <- unlist(lapply(mu_i, function(mu) rnorm(R_per_cluster, 
                                                mean = mu, 
                                                sd = sqrt(sigma2))))
  
  # IF Poisson
  } else if (distribution == "poisson") {
    
    # Simulate cluster level mean
    eta_i <- alpha + beta * X + rnorm(n_clusters, 
                                      mean = 0, 
                                      sd = sqrt(gamma2))
    mu <- exp(rep(eta_i, each = R_per_cluster))
    
    # Generate Poisson outcomes
    Y <- rpois(length(mu), lambda = mu)
  }
    
  # Expand cluster-level predictors to individual observations
  cluster <- rep(1:n_clusters, each = R_per_cluster)
  treatment <- rep(X, each = R_per_cluster)
  # Create a data frame
  data <- data.frame(cluster, treatment, Y)
  
  # Fit the model
  fit <- if (distribution == "normal") {
    lmer(Y ~ treatment + (1 | cluster), data = data)
  } else if (distribution == "poisson") {
    glmer(Y ~ treatment + (1 | cluster), 
          family = poisson(link = "log"), data = data,
          control = glmerControl(optimizer = "bobyqa"))
  }
    
  estimated_beta <- summary(fit)$coefficients["treatmentTRUE", "Estimate"]
  beta_se <- summary(fit)$coefficients["treatmentTRUE", "Std. Error"]
  
  l_confint <- estimated_beta - 1.96 * beta_se
  u_confint <- estimated_beta + 1.96 * beta_se
  
  return(c(estimated_beta, l_confint, u_confint))
}


# Function to run multiple simulations
run_simulations <- function(grid, alpha, distribution, n_replications, ratio = TRUE) {
  pb <- progress_bar$new(total = nrow(grid))
  results <- list()
  
  for (i in seq_len(nrow(grid))) {
    pb$tick() # report progress
    params <- grid[i, ]
    
    sim_metrics <- replicate(
      n_replications,
      simulate_and_evaluate(
        params$n_clusters, params$R_per_cluster,
        alpha, params$beta, params$gamma2, params$sigma2, 
        distribution
      ),
      simplify = FALSE
    )
    
    results[[i]] <- data.frame(
      beta = params$beta,
      gamma2 = params$gamma2,
      sigma2 = params$sigma2,
      n_clusters = params$n_clusters,
      R_per_cluster = params$R_per_cluster,
      replication = seq_along(sim_metrics),
      estimated_beta = sapply(sim_metrics, `[`, 1),
      lower_confint = sapply(sim_metrics, `[`, 2),
      upper_confint = sapply(sim_metrics, `[`, 3)
    )
    
    if (ratio == TRUE){
      results[[i]] <- results[[i]] %>% mutate(ratio = params$ratio) 
    }
  }
  
  bind_rows(results)
}


# Main Script ----------------------------------------------------------

### Compute all possible cluster designs by cost ratio 
# Relative cost scenarios - 2:1 (Original)
designs_2_1 <- compute_feasible_designs(c1, c2, budget) %>% 
  mutate(ratio = "2:1")

# Relative cost scenarios - 5:1
designs_5_1 <- compute_feasible_designs(5 * c2, c2, budget) %>% 
  mutate(ratio = "50:1")

# Relative cost scenarios - 10:1
designs_10_1 <- compute_feasible_designs(10 * c2, c2, budget) %>% 
  mutate(ratio = "10:1")

all_designs <- rbind(designs_2_1, designs_5_1, designs_10_1)
write.csv(all_designs, "outputs/all_designs.csv", row.names = FALSE)

### Compute grid for 2:1. 5:1, 10:1 feasible designs 
cost_ratio_grid <- all_designs[,-3] %>% mutate(
  beta = 1,
  gamma2 = 1,
  sigma2 = 1
)


### Compute all possible parameter combinations, with 2:1 feasible designs 
param_grid <- expand.grid( 
  beta = beta_values,
  gamma2 = gamma2_values,
  sigma2 = sigma2_values
)

# Replicate parameter grid to match three cost ratio scenarios in designs_2_1
param_grid <- do.call(rbind, 
                      replicate(3, param_grid, simplify = FALSE))

param_grid$n_clusters <- rep(designs_2_1$n_clusters, each = nrow(designs_2_1))
param_grid$R_per_cluster <- rep(designs_2_1$R_per_cluster, each = nrow(designs_2_1))


#### Part 1
### Simulate normal, varied parameters
normal_varied_parameter <- run_simulations(param_grid, alpha, "normal", n_replications, ratio = FALSE)
write.csv(normal_varied_parameter, "outputs/normal_varied_parameter.csv", row.names = FALSE)

#### Part 2
### Simulate normal, varied cost ratios
normal_varied_cost <- run_simulations(cost_ratio_grid, alpha, "normal", n_replications)
write.csv(normal_varied_cost, "outputs/normal_varied_cost.csv", row.names = FALSE)

#### Part 3
### Simulate poisson, varied parameters
poisson_varied_parameter <- run_simulations(param_grid, alpha, "poisson", n_replications, ratio = FALSE)
write.csv(poisson_varied_parameter, "outputs/poisson_varied_parameter.csv", row.names = FALSE)

### Simulate poisson, varied cost ratios
poisson_varied_cost <- run_simulations(cost_ratio_grid, alpha, "poisson", n_replications)
write.csv(poisson_varied_cost, "outputs/poisson_varied_cost.csv", row.names = FALSE)

