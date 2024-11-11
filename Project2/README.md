# Moderators and Predictors Analysis for Smoking Abstinence with Behavioral Treatment And Pharmacotherapy

[Report PDF](/Project2/project2.pdf)

## Background

Smoking cessation is particularly challenging for individuals with major depressive disorder (MDD). Pharmacotherapy by using the drug Varenicline is effective for aiding smoking cessation, while behavior treatments may help depression and impact cessation success among MDD smokers. This project builds on prior research by examining the baseline characteristics as potential moderators and identify predictors of end-of-treatment (EOT) abstinence among adults with MDD.

## Methods

Data were processed with transformations for normality and multiple imputation for missing values. To explore baseline moderators of behavior treatment effects on abstinence, logistic regression models were fitted on each imputed dataset, and consistent predictors across imputations were identified. Lasso regression was also applied for robust variable selection across imputed datasets, focusing on main effects and treatment interactions. Key predictors were identified based on the Lasso variable selection.

## Data

The data consists of 300 participants, with their characteristics at baseline, treatment group, and the end-of-treatment (EOT) smoking abstinence. Preprocessing, transformation, and more cleaning was performed in the analysis. The data contains demographic factors such as age, sex, race, and socioeconomic indicators like income and education. Additionally, clinical and behavioral factors are accounted for, including baseline nicotine dependence, depression symptoms, smoking habits, and reward valuation associated with smoking. Indicators of prior diagnoses of major depressive disorder (MDD), antidepressant medication use, and readiness to quit smoking are also included to provide a comprehensive view of psychological and behavioral readiness. The data also included biological markers such as nicotine metabolism ratio (NMR) and preference for menthol cigarettes help capture individual differences that may impact treatment outcomes.

## Methods

The reduced effectiveness of behavioral activation among menthol users highlights a need for targeted behavioral activation treatment for exclusive menthol smokers. Key predictors of abstinence, including Nicotine Metabolism Ratio, the interaction between Varenicline and antidepressant use, FTCD score, and its interaction with Behavioral Activation, shows the importance of biological, psychological, and behavioral factors in intervention design. These findings suggests that a tailored behavioral treatment for MDD smokers could be beneficial in improving smoking cessation success.

## Results

Moderator analysis found that menthol cigarette use negatively moderated the effectiveness of behavioral activation. Predictor analysis showed that the Nicotine Metabolism Ratio, interaction between Varenicline and Antidepressant Medication Use, FTCD Score, and its interaction between Behavioral Activation (BA) are strong predictors that meaningfully influence smoking abstinence outcomes in individuals with MDD.

The reduced effectiveness of behavioral activation among menthol users highlights a need for targeted behavioral activation treatment for exclusive menthol smokers. Key predictors of abstinence shows the importance of biological, psychological, and behavioral factors in intervention design. These findings suggests that a tailored behavioral treatment for MDD smokers could be beneficial in improving smoking cessation success.

The full report can be found [here](/Project2/project2.pdf).

## Files

### Report

`project2.qmd`: The QMarkdown file for the report, includes both code and detail explanations in the analysis.

`project2.pdf`: The PDF generated from the QMarkdown file. This is in a complied form of report with code appendix at the back.

## Dependencies

The following packages were used in this analysis:

-   Data Manipulation: `tidyverse`, `dplyr`, `readr`, `mice`, `caret`
-   Table Formatting: `gtsummary`, `knitr`, `kableExtra`, `tidyr`
-   Data Visualization: `visdat`, `ggplot2`, `DataExplorer`, `corrplot`, `gridExtra`
-   Regression Model and Evaluation: `stats`, `MASS`, `glmnet`, `car`, `pROC`, `predtools`,

## References

-   [1] American Lung Association. (n.d.). Tobacco Facts \| State of tobacco control. Retrieved from [https://www.lung.org/research/sotc/facts#:\~=Smoking%20is%20the%20number%20one,in%20the%20U.S.%20each%20year](https://www.lung.org/research/sotc/facts#:~:text=Smoking%20is%20the%20number%20one,in%20the%20U.S.%20each%20year).

-   [2] Breslau, N., Kilbey, M. M., & Andreski, P. (1992). Nicotine withdrawal symptoms and psychiatric disorders: findings from an epidemiologic study of young adults. The American Journal of Psychiatry, 149(4), 464–469. <https://doi.org/10.1176/ajp.149.4.464>

-   [3] Hitsman, B., Papandonatos, G. D., Gollan, J. K., Huffman, M. D., Niaura, R., Mohr, D. C., Veluz-Wilkins, A. K., Lubitz, S. F., Hole, A., Leone, F. T., Khan, S. S., Fox, E. N., Bauer, M., Wileyto, E. P., Bastian, J., & Schnoll, R. A. (2023). Efficacy and safety of combination behavioral activation for smoking cessation and varenicline for treating tobacco dependence among individuals with current or past major depressive disorder: A 2x2 factorial, randomized, placebo-controlled trial. Addiction, 118(9), 1710–1725. <https://doi.org/10.1111/add.16209>
