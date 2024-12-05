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
alpha <- 5  
beta = 1  
gamma2_values <- 1   
sigma2_values <- 1 

c1 <- 20           # Cost of first sample in a cluster
c2 <- 10           # Cost of additional samples
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

# Relative cost scenarios - 2:1 (Original)
feasible_designs <- compute_feasible_designs(20, 10) %>% 
  mutate(ratio = "2:1")

# Relative cost scenarios - 5:1
feasible_designs2 <- compute_feasible_designs(50, 10) %>% 
  mutate(ratio = "50:1")

# Relative cost scenarios - 10:1
feasible_designs3 <- compute_feasible_designs(100, 10) %>% 
  mutate(ratio = "10:1")

param_grid <- rbind(feasible_designs[,-3], feasible_designs2[,-3], feasible_designs3[,-3])

# Save the results to CSV
write.csv(param_grid, "all_feasible_designs.csv", row.names = FALSE)



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
  # parameters
  beta <- 1
  gamma2 <- 1
  sigma2 <- 1
  n_clusters <- param_grid$n_clusters[i]
  R_per_cluster <- param_grid$R_per_cluster[i]
  ratio <- param_grid$ratio[i]
  
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
    ratio = ratio,
    replication = seq_along(simulation_metrics),
    estimated_beta = sapply(simulation_metrics, `[`, 1),
    lower_confint = sapply(simulation_metrics, `[`, 2),
    upper_confint = sapply(simulation_metrics, `[`, 3)
  )
}

# Combine results into a single data frame
final_results <- bind_rows(results)

# Save the aggregated results to CSV
write.csv(final_results, "aggregated_results2.csv", row.names = FALSE)






