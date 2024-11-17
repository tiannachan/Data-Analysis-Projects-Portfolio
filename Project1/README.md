# Exploring the Impact of Environment and Weather Conditions on Marathon Performance

[Report PDF](project1.pdf)

## Background

Previous studies have shown aerobic performance declines even under just modest hyperthermia in hot environments [1]. Specifically, in marathon running, higher temperatures are associated with slower race times [2]. Additionally, older adults may struggle more in hot and humid conditions due to a reduced ability to dissipate heat effectively [3]. Sex differences in endurance running have also been observed, with male and female exhibiting distinct physiological and thermoregulatory responses under environmental conditions [4].

## Methods

This project aims to explore different environmental factors that impact marathon performance between gender and across age. This includes not only temperature, but humidity, solar radiation, wind, and air quality on a race date. Understanding the associations provides a more holistic comprehension on how environmental conditions influence performance in endurance events such as marathon. It could also be beneficial for athletes or coaches in forming their targeted strategies based on their own characteristics or weather.

We will start with data preprocessing and begin the exploratory, by first examining the age and sex effects on marathon performance. Then, we will factor in the air quality information for PM2.5 and Ozone level. Lastly, weather parameters will be investigated and a discussion on the results is included. All explorations will be presented through plots, tables, and regression models.

## Data

The `project1` data set contains info and results for 11564 participants (14-85 years) in the marathon races at Boston, New York City, Chicago, Twin Cities, and Grandmas from 1993 to 2016. It also includes 10 weather parameters, such as dry and wet bulb temperature, relative humidity, black globe temperature and more. This includes the calculated variables `WBGT` (Wet Bulb Globe Temperature, calculated by the three temperatures) and `Flag` (Groups for WBGT). The project also utilized the `course_record` data that included the course record for each gender at each race and year. To further assess the environmental impact, AQI data was obtained using the R package RAQSAPI, grabbing data from the US Environmental Protection Agency's API.

## Methods

The report starts with data preprocessing and showing some summary statistics for the data sets. To start the exploratory, the age and sex effects on marathon performance were first examined. Air quality information for PM2.5 and Ozone level was then factored in. Last, weather parameters are investigated and a discussion on the results is included. All exploration was presented through plots, tables, and regression models.

## Results

Results reveals significant differences based on gender and age, which also applies to air quality impacts in the measures of PM2.5 and ozone levels. Additionally, relative humidity and wet bulb globe temperature are the most influential weather factors affecting performance, with effects vary by age. These findings offer valuable insights for athletes and coaches to optimize race-day strategies based on environmental conditions and individual characteristics.

The full report can be found [here](project1.pdf).

## Files

### R

`aqi.R`: The R code used to obtain Air Quality Info from the US Environmental Protection Agency's API (Code provided in class).

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
