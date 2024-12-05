# Load libraries
library(readr)
library(tidyverse)
library(knitr)
library(tidyr)   
library(dplyr)    
library(car)
library(ggpubr)
library(lme4) # For lmer

set.seed(2550)

# Parameters
alpha <- 5         # Intercept
beta = c(1, 2, 3) # Small/large treatment effect
gamma2_values <- c(1, 10)    # Low/high between-cluster variance
sigma2_values <- c(1, 10)    # Low/high within-cluster variance

budget <- 2000     # Total budget

compute_feasible_designs <- function(c1, c2){
  calculate_cost <- function(n_clusters, R_per_cluster, c1, c2) {
    total_cost <- n_clusters * (c1 + (R_per_cluster - 1) * c2)
    return(total_cost)
  }
  
  designs <- expand.grid(
    n_clusters = seq(5, 15, by = 5),  # Number of clusters
    R_per_cluster = seq(10, 50, by = 2)  # Observations per cluster
  )
  
  designs$cost <- mapply(
    calculate_cost,
    designs$n_clusters,
    designs$R_per_cluster,
    MoreArgs = list(c1 = c1, c2 = c2)
  )
  
  feasible_designs <- designs %>%
    filter(cost <= budget) %>%         # Only designs within budget
    group_by(n_clusters) %>%           # Group by n_clusters
    filter(cost == max(cost)) %>%      # Select the design with the highest cost
    ungroup()    
  
  return(feasible_designs)
}

feasible_designs <- compute_feasible_designs(c1 = 20, c2 = 10)

feasible_designs %>% 
  arrange(n_clusters) %>%
  kable()

param_grid <- expand.grid( 
  beta = beta_values,
  gamma2 = gamma2_values,
  sigma2 = sigma2_values
)

param_grid <- rbind(param_grid, param_grid, param_grid)

param_grid$n_clusters <- rep(feasible_designs$n_clusters, each = nrow(feasible_designs))
param_grid$R_per_cluster <- rep(feasible_designs$R_per_cluster, each = nrow(feasible_designs))



# Function to simulate data and estimate beta
simulate_and_evaluate <- function(n_clusters, R_per_cluster, alpha, beta, gamma2, sigma2) {
  
  # Simulate X (Treatment assignment)
  X <- rbernoulli(n_clusters, 0.5)
  
  if (length(unique(X)) < 2) return(c(NA, NA, NA))  # Return NA if variability is insufficient
  
  # Simulate cluster level mean
  mu_i0 <- alpha + beta * X
  mu_i <- rnorm(n_clusters, mean = mu_i0, sd = sqrt(gamma2))
  
  # Simulate a cluster
  Y <- unlist(lapply(mu_i, function(mu) rnorm(R_per_cluster, mean = mu, sd = sqrt(sigma2))))
  cluster <- rep(1:n_clusters, each = R_per_cluster)
  treatment <- rep(X, each = R_per_cluster)
  
  # Create a data frame
  data <- data.frame(cluster, treatment, Y)
  
  # Fit a linear model to estimate beta
  fit <- lmer(Y ~ treatment + (1 | cluster), data = data)
  
  estimated_beta <- summary(fit)$coefficients["treatmentTRUE", "Estimate"]
  
  l_confint <- confint(fit)["treatmentTRUE", ][1]
  u_confint <- confint(fit)["treatmentTRUE", ][2]
  
  return(c(estimated_beta, l_confint, u_confint))
}




results <- list()
for (i in seq_len(nrow(param_grid))) {
  # Extract parameters
  beta <- param_grid$beta[i]
  gamma2 <- param_grid$gamma2[i]
  sigma2 <- param_grid$sigma2[i]
  n_clusters <- param_grid$n_clusters[i]
  R_per_cluster <- param_grid$R_per_cluster[i]
  
  # Run 10 replications
  simulation_metrics <- replicate(
    10,
    simulate_and_evaluate(n_clusters, R_per_cluster, alpha, beta, gamma2, sigma2),
    simplify = FALSE
  )
  
  # Store results
  results[[i]] <- data.frame(
    beta = beta,
    gamma2 = gamma2,
    sigma2 = sigma2,
    n_clusters = n_clusters,
    R_per_cluster = R_per_cluster,
    replication = seq_along(simulation_metrics),
    estimated_beta = sapply(simulation_metrics, `[`, 1),
    lower_confint = sapply(simulation_metrics, `[`, 2),
    upper_confint = sapply(simulation_metrics, `[`, 3)
  )
}

# Combine results into a single data frame
final_results <- bind_rows(results)

# Save the aggregated results to CSV
write.csv(final_results, "aggregated_results.csv", row.names = FALSE)






