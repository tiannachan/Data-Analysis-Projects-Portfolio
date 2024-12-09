# Data Analysis Projects

This repository includes R data analysis projects that showcases my skills in three distinct areas - exploratory data analysis, regression analysis, and simulation studies.

## Project 1 - Exploratory Data Analysis

[Exploring the Impact of Environment and Weather Conditions on Marathon Performance](/Project1/README.md)

**Abstract**

This project explores the impact of environmental factors—including temperature, humidity, solar radiation, wind, and air quality—on marathon performance across gender and age. Using data from major U.S. marathons (1993-2016), combined with weather and air quality information, the relationships between these factors and race times were examined. Results reveals significant differences based on gender and age, which also applies to air quality impacts in the measures of PM2.5 and ozone levels. Additionally, relative humidity and wet bulb globe temperature are the most influential weather factors affecting performance, with effects vary by age. These findings offer valuable insights for athletes and coaches to optimize race-day strategies based on environmental conditions and individual characteristics.

## Project 2 - Regression Analysis

[Moderators and Predictors Analysis for Smoking Abstinence with Behavioral Treatment And Pharmacotherapy](/Project2/README.md)

**Abstract**

This project builds on prior research by examining the baseline characteristics as potential moderators and identify predictors of end-of-treatment (EOT) abstinence among adults with MDD. Data were processed with transformations for normality and multiple imputation for missing values. To explore baseline moderators of behavior treatment effects on abstinence, lasso models focusing on main effects and treatment interactions were fitted on each imputed dataset for robust variable selection across imputed datasets. The fitted models were pooled to a final model with key predictors identified. Model results are compared between the data with and withour transformation. 

Exclusively menthol cigarette use negatively moderated the effectiveness of behavioral activation. FTCD Score, interaction between Varenicline and NMR, being Non-Hispanic White, and the interaction between Varenicline and Age are the strongest predictors that meaningfully influence smoking abstinence outcomes in individuals with MDD. These findings suggests that a tailored behavioral treatment for MDD smokers could be beneficial in improving smoking cessation success.

## Project 3 - Simulation Studies

[Optimal Experimental Design under Budget Constraints: Applications to Normal and Poisson Distributed Data](/Project3/README.md)

**Abstract**

This project investigated optimal experimental design under budget constraints and varying parameters through a simulation study. Using a hierarchical model, we evaluate cluster randomized trials to estimate the treatment effect on Normal and Poisson simulated data. These methods are particularly relevant for applications like DNA sequencing, where clusters represent groups of samples processed together within a single sequencing run. Shared correlations within clusters, coupled with fixed and variable costs per sample, introduce unique statistical and budgetary challenges.

Our findings showed that more stable and accurate treatment effect estimates are consistently produced by designs with larger numbers of clusters and moderate within-cluster observations, compared to the smaller ones. Between-cluster and within-cluster variances significantly affect the estimates, especially in smaller clusters. Results remain largely consistent when extending to a Poisson distribution. Cost ratio analysis demonstrates slight differences between normal and poisson distributed data. For Normal data, lower or medium initial costs has a more precise result with lower mean squared error (MSE) and higher coverage or lower bias respectively. For Poisson data, lower initial costs consistently resulted in the lowest MSE, absolute bias, and higher coverage. These findings provide valuable insights into the trade-offs between cost, design complexity, and statistical performance, guiding researchers to optimize experimental designs under constrained resources.
