# Optimal Experimental Design under Budget Constraints: Applications to Normal and Poisson Distributed Data

[Report PDF](project3.pdf)

## Abstract

This project investigated optimal experimental design under budget constraints and varying parameters through a simulation study. Using a hierarchical model, we evaluate cluster randomized trials to estimate the treatment effect on Normal and Poisson simulated data. These methods are particularly relevant for applications like DNA sequencing, where clusters represent groups of samples processed together within a single sequencing run. Shared correlations within clusters, coupled with fixed and variable costs per sample, introduce unique statistical and budgetary challenges.

Our findings showed that more stable and accurate treatment effect estimates are consistently produced by designs with larger numbers of clusters and moderate within-cluster observations, compared to the smaller ones. Between-cluster and within-cluster variances significantly affect the estimates, especially in smaller clusters. Results remain largely consistent when extending to a Poisson distribution. Cost ratio analysis demonstrates slight differences between normal and poisson distributed data. For Normal data, lower or medium initial costs has a more precise result with lower mean squared error (MSE) and higher coverage or lower bias respectively. For Poisson data, lower initial costs consistently resulted in the lowest MSE, absolute bias, and higher coverage. These findings provide valuable insights into the trade-offs between cost, design complexity, and statistical performance, guiding researchers to optimize experimental designs under constrained resources.

## Introduction

Cluster-randomized trials are essential for evaluating interventions when individual-level randomization is impractical or unethical. There are also applications in DNA sequencing, where clusters of DNA represents groups of samples processed together in a single sequencing run when they have shared correlations within clusters.

However, optimizing the design of such trials is challenging, especially under budget constraints. The cost per sample in DNA sequencing often include fixed and variable costs, which is parallel to our study design. Inefficient allocation of resources can lead to suboptimal designs that compromise the statistical power or precision of the estimated treatment effects.

In this project, we aim to design a simulation study to look at optimal experimental design under varying parameters, budget constraints, and cost structures. By leveraging the ADEMP framework (Aims, Data-generating mechanisms, Estimands, Methods, and Performance measures), we simulate cluster-randomized trials under two common data distributions: Normal and Poisson. Our focus is on understanding how design elements—such as the number of clusters and observations per cluster—impact the estimation of the treatment effect ($\beta$) under different cost structures and parameters.

Through this work, we aim to provide practical guidance for researchers to optimize experimental designs, ensuring resource-efficient and statistically robust methodologies, especially in high-throughput fields like DNA sequencing.

## Methods

We will design a simulation study using the ADEMP framework as follows.

**Aims:** To estimate the treatment effect $\beta$ and determine the optimal number of clusters $n$ and observations per cluster $R$ under a budget and cost constraints.

**Data-generating mechanisms:**

$X_i$ is the binary treatment variable that indicates whether a cluster is assigned to the treatment group $X_i = 1$ or control group $X_i = 0$. The hierarchical model for the normal distribution setting is given below.

-   $\mu_{i0} = \alpha + \beta X_i$ (fixed effect, $\mu_{i0} = \alpha$ or $\mu_{i0} = \alpha+\beta$)

-   $\mu_i \mid \varepsilon_i = \mu_{i0} + \varepsilon_i$ with $\varepsilon_i \sim N(0, \gamma^2)$, or in other words $\mu_i \sim N(\mu_{i0}, \gamma^2)$

-   $Y_{ij} \mid \mu_i = \mu_i + e_{ij}$ with $e_{ij} \sim \text{iid } N(0, \sigma^2)$, or in other words, $Y_{ij} \mid \mu_i \sim N(\mu_i, \sigma^2)$

For the hierarchical model for the poisson distribution setting,

-   $log(\mu_i) \sim N(\alpha + \beta X_i, \gamma^2)$.

-   $Y_{ij} \mid \mu_i \sim \text{Poisson}(\mu_i)$. Since the sum of iid Poisson random variables is still Poisson, we may simply have $Y_i := \sum_{j=1}^{R} Y_{i,j}$ and $Y_i \mid \mu_i \sim \text{Poisson}(R \mu_i)$ to reduce computational complexity.

**Estimands:** The estimand is $\beta$, the fixed treatment effect, representing the average difference between treatment and control groups.

**Methods:** The simulation study consists of three parts:

[Part 1 (Varying Parameters - Normal Distribution):]{.underline} We will start with setting a total budget $B = \$2000$ in dollars, with sampling costs $c_1 = 20$ for the first observation in each cluster and $c_2 = 10$ for each additional observations in the same cluster, such that $c_2 < c_1$. The number of clusters and observations per cluster were varied from 5 to 15 in increments of 5 and 10 to 50 in increments of 2 respectively. These ranges represent scenarios with fewer, more resource-intensive clusters versus more clusters with potentially smaller sample sizes per clusters. With these constraints, we will find out the feasible number of clusters $n$ and observations per cluster $R$ designs that $Cost = n \cdot [c_1 +  (R-1) \cdot c_2]$, and for each cluster size, we select the one with the maximum allowable cost for each cluster size.

We will then pair these designs with all combinations of design and parameter settings. The intercept $\alpha$ is fixed at 5 since changing it would only shift the result but not affecting the performance. The treatment effect ($\beta$) was set to represent small to large effects (1, 2, and 3), reflecting scenarios with varying levels of detectable differences. Between and within cluster variances ($\gamma^2$ and $\sigma^2$) were set to low and high levels (1 and 10) to capture conditions of low and high heterogeneity across and within clusters. Considering all possible cases with varying parameters, we repeat the simulations for 500 iterations to estimate the performance of each design using a linear mixed-effects model.

[Part 2 (Varying Cost Ratio - Normal Distribution):]{.underline} We will explore relationships between the underlying data generation mechanism parameters and the relative costs $c_1/c_2$ and how these impact the optimal study design. We repeat the analysis by fixing the parameters and vary the relative costs. The treatment effect ($\beta$), within and between cluster variances ($\gamma^2$ and $\sigma^2$) will be fixed at 1.

[Part 3 (Extension to Poisson Model):]{.underline} We will repeat part 1 and 2 but changing to the setting in which $Y$ follows a Poisson distribution. We aim to determine whether a Poisson model leads to different optimal designs under similar budget constraints and parameter settings, which we will compare the performance measures (absolute bias, variance, MSE, and coverage) between the normal and Poisson settings to assess how the data distribution affects design efficiency.

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

Our findings highlight that designs with larger numbers of clusters and moderate within-cluster observations (n = 15, R = 12) consistently yield more stable and accurate estimates of the treatment effect, compared to the smaller ones. Variations in between-cluster ($\gamma^2$) and within-cluster ($\sigma^2$) variances significantly affect the estimates, with smaller clusters being more sensitive to increased variance. When extending to a Poisson distribution, results remain largely consistent, although overall lower absolute bias and variability are observed.

Cost ratio analysis demonstrates differences between normal and poisson distributed data. For normal, small initial costs (2:1) have a more precise result with lower MSE and higher coverage, while medium initial costs (10:1) has the lowest absolute bias. However, for poisson, lower initial costs (2:1) consistently have the lowest MSE, absolute bias, and higher coverage. These findings provide valuable insights into the trade-offs between cost, design complexity, and statistical performance.

Overall, this work offers a practical framework for optimizing experimental designs under constrained resources, with broad applicability across fields, including clinical trials and DNA sequencing. Future studies can build on these findings by incorporating real-world data validation, more complex cost models, and additional data-generating mechanisms to further refine design recommendations.

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
