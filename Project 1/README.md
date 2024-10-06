# Exploring the Impact of Environment and Weather to Marathon Performance, by Age and Sex

## Background

Previous studies shown negative associations on endurance exercise performance and environmental temperature[1], which magnify during long distance events if temperature is warm [2]. It was also shown that the older population were less able to dissipate heat [3], and there are sex differences [4].

## Methods

This project aims to explore different environmental factors that impact marathon performance between gender and across age. This includes not only temperature, but humidity, solar radiation, wind, and air quality on a race date. Understanding the associations provides a more holistic comprehension on how environmental conditions influence performance in endurance events such as marathon. It could also be beneficial for athletes or coaches in forming their targeted strategies based on their own characteristics or weather.

## Data

The project1 data set contains info and results for each participant (14-85 years) in the marathon races at Boston, New York City, Chicago, Twin Cities, and Grandmas from 1993 to 2016. It also includes weather parameters, such as dry and wet bulb temperature, relative humidity, black globe temperature and more. This results data already includes calculated variables WBGT (Wet Bulb Globe Temperature, calculated by the three temperature) and Flag (Groups for WBGT). The project also utilized the course_record data that included the record for each race, at each year. To further assess the environmental impact, AQI data was obtained using provided code in class, which grabbed data from an API using the R package RAQSAPI.

## Methods

This report starts with data preprocessing and showing some summary statistics for the data sets. To start the exploratory, I first examined the age and sex effects on marathon performance. Air quality information for PM2.5 and Ozone level was then factored in. Lastly, weather parameters are investigated and a discussion on the results is included. All exploration was presented through plots, tables, and regression models.

## Results

Age and sex differs in their average marathon performance - On average, men has a longer course time and both sex slows down. There is also impacts on environmental conditions - It was statistically significant that it differ by age, but not by sex. For weather parameters, wet bulb temperature and Flag Conditions (especially Red) have the largest positive impacts on time (i.e., largest negative impacts on performance). This means the hotter and more humid condition are associated with worse performance. On the other hand, Dew Point (DP) has negative impact on time (i.e., positive impact on performace), so higher dew point could be a favorable condition for better performance.

The full report can be found [here](/project1.pdf).

## Files

### Report

`project1.qmd`: The QMarkdown file for the report, includes both code and detail explanations in the analysis.

`project1.pdf`: The PDF generated from the QMarkdown file. This is in a complied form of report with code appendix at the back.

## Dependencies

The following packages were used in this analysis:

-   Data Manipulation: `tidyverse`, `dplyr`, `readr`
-   Table Formatting: `gtsummary`, `knitr`, `kableExtra`, `tidyr`
-   Data Visualization: `visdat`, `ggplot2`, `DataExplorer`, `patchwork`

## References

-   [1] Ely, B. R., Cheuvront, S. N., Kenefick, R. W., & Sawka, M. N. (2010). Aerobic performance is degraded, despite modest hyperthermia, in hot environments. Med Sci Sports Exerc, 42(1), 135-41.
-   [2] Ely, M. R., Cheuvront, S. N., Roberts, W. O., & Montain, S. J. (2007). Impact of weather on marathon-running performance. Medicine and science in sports and exercise, 39(3), 487-493.
-   [3] Kenney, W. L., & Munce, T. A. (2003). Invited review: aging and human temperature regulation. Journal of applied physiology, 95(6), 2598-2603.
-   [4] Besson, T., Macchi, R., Rossi, J., Morio, C. Y., Kunimasa, Y., Nicol, C., ... & Millet, G. Y. (2022). Sex differences in endurance running. Sports medicine, 52(6), 1235-1257.
