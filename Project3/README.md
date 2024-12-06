# Optimal Experimental Design under Budget Constraints: Applications to Normal and Poisson Distributed Data

[Report PDF](project3.pdf)

## Introduction

This project investigated optimal experimental design under budget constraints and varying parameters through a simulation study. Using a hierarchical model, we evaluate cluster randomized trials to estimate the treatment effect on Normal and Poisson simulated data. These methods are particularly relevant for applications like DNA sequencing, where clusters represent groups of samples processed together within a single sequencing run. Shared correlations within clusters, coupled with fixed and variable costs per sample, introduce unique statistical and budgetary challenges.

## Methods

We designed a simulation study using the ADEMP framework as follows. Please read the project pdf for more details.

**Aims:** To estimate the treatment effect $\beta$ and determine the optimal number of clusters $n$ and observations per cluster $R$ under a budget and cost constraints.

**Data-generating mechanisms:** $X_i$ is the binary treatment variable. Then, we used hierarchical models with parameters $\beta$, $\sigma^2$, and $\gamma^2$ for both the normal and poisson distribution.

**Estimands:** The estimand is $\beta$, the fixed treatment effect, representing the average difference between treatment and control groups.

**Methods:** The simulation study consists of three parts:

-   Part 1 (Varying Parameters - Normal Distribution):
-   Part 2 (Varying Cost Ratio - Normal Distribution)
-   Part 3 (Extension to Poisson Model)

## Data

Below shows the head of the simulated data. All simulated data for the varying parameters parts of the project follows the same structure. Additional column for the cost ratio information is included in the varying cost ratio data. With 500 iterations each combination, there are 18,000 and 9,000 observations simulated for the varying parameters data in Normal and Poisson distribution respectively. 3500 observations were simulated for the cost ratio sections.

| beta | gamma2 | sigma2 | n_clusters | R_per_cluster | replication | estimated_beta | lower_confint | upper_confint |
|--------|--------|--------|--------|--------|--------|--------|--------|--------|
| 1    | 1      | 1      | 15         | 12            | 1           | 0.760          | -0.128        | 1.650         |
| 1    | 1      | 1      | 15         | 12            | 2           | 0.898          | -0.415        | 2.210         |
| 1    | 1      | 1      | 15         | 12            | 3           | 0.247          | -0.688        | 1.180         |
| 1    | 1      | 1      | 15         | 12            | 4           | 1.540          | 0.799         | 2.270         |
| 1    | 1      | 1      | 15         | 12            | 5           | 1.390          | 0.427         | 2.350         |
| 1    | 1      | 1      | 15         | 12            | 6           | 0.756          | -0.404        | 1.920         |
| 1    | 1      | 1      | 15         | 12            | 7           | 0.176          | -0.963        | 1.320         |
| 1    | 1      | 1      | 15         | 12            | 8           | 0.868          | -0.382        | 2.120         |
| 1    | 1      | 1      | 15         | 12            | 9           | 0.617          | -0.745        | 1.980         |
| 1    | 1      | 1      | 15         | 12            | 10          | 0.233          | -1.030        | 1.500         |

## Results

The full report can be found [here](project3.pdf).

More stable and accurate treatment effect estimates are consistently produced by designs with larger numbers of clusters and moderate within-cluster observations, compared to the smaller ones. Between-cluster and within-cluster variances significantly affect the estimates, especially in smaller clusters. Results remain largely consistent when extending to a Poisson distribution. 

Cost ratio analysis demonstrates slight differences between normal and poisson distributed data. For Normal data, lower or medium initial costs has a more precise result with lower mean squared error (MSE) and higher coverage or lower bias respectively. For Poisson data, lower initial costs consistently resulted in the lowest MSE, absolute bias, and higher coverage. These findings provide valuable insights into the trade-offs between cost, design complexity, and statistical performance, guiding researchers to optimize experimental designs under constrained resources..

## Files

### Report

`project3.qmd`: The QMarkdown file for the report, includes both code and detail explanations in the analysis.

`project3.pdf`: The PDF generated from the QMarkdown file. This is in a complied form of report with code appendix at the back.

`data_simulation.R`: The R script used to generate data. These generated data are saved in the outputs folder:

-   `normal_varied_parameter.csv`: Normally distributed data with varying parameters

-   `normal_varied_cost.csv`: Normally distributed data with varying cost constraints

-   `poisson_varied_parameter.csv`: Poisson distributed data with varying parameters

-   `poisson_varied_cost.csv`: Poisson distributed data with varying cost constraints

-   `all_designs.csv`: All chosen cluster designs by cost ratio

## Dependencies

The following packages were used in this analysis:

-   Data Manipulation: `tidyverse`, `dplyr`, `readr`, `progress`
-   Table Formatting: `knitr`, `kableExtra`, `tidyr`
-   Data Visualization: `ggplot2`, `gridExtra`, `ggpubr`
-   Regression Model and Evaluation: `stats`
