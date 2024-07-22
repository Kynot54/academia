# Load the Tidyverse Library
library(tidyverse)
library(modelr)
library(ggplot2)

# Read the Data in from the CSV File
dataOnCovid = read_csv("https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv")
# Pull-in Second CSV File for Data
worldBankData = read_csv("/home/kyle/Documents/School/spring2024/cpsc375/Final_Proj/world-bank-pop.csv")

# STEP 1: Filtering and Tidying Data
#Tidy the Data from World Bank Data Set so the Data Displays Correctly on a "inner_join()" when joining the two tables together
worldBankDataTidied <- worldBankData %>% mutate(`2023 [YR2023]` = as.numeric(`2023 [YR2023]`)) %>% select(-`Series Name`) %>% pivot_wider(id_cols=c(`Country Name`, `Country Code`),names_from=`Series Code`,values_from=`2023 [YR2023]`) %>% filter(SP.POP.TOTL > 1e6)

# Drop Countries whose population is less than 1 million & create Column to Predict Deaths 2wks Ahead
dataOnCovid <- dataOnCovid %>% filter(population > 1e6) %>% filter(date >= as.Date("2023-01-01")) %>% mutate(date = date - 14, new_deaths_smoothed_2wk=new_deaths_smoothed, new_deaths_smoothed=lag(new_deaths_smoothed,14))

# Join the Data into one Table on Country Code
completeDataTable <- inner_join(dataOnCovid, worldBankDataTidied, by=c("iso_code"="Country Code", "location"="Country Name")) %>% filter(nchar(iso_code) == 3) %>% select(-continent) %>% select(where(~ any(!is.na(.)))) %>% select(iso_code, location, date, new_deaths_smoothed_2wk, new_deaths_smoothed, sort(names(.)))

# STEP 2: Linear Modeling
# Generate Transformed Variables 
completeDataTable <- completeDataTable %>% mutate(SP.POP.65UP.TOTL=(SP.POP.6569.MA + SP.POP.6569.FE + SP.POP.7074.MA + SP.POP.7074.FE + SP.POP.7579.MA + SP.POP.7579.FE + SP.POP.80UP.MA + SP.POP.80UP.FE)) %>% mutate(SP.POP.65UP.MA=(SP.POP.6569.MA + SP.POP.7074.MA + SP.POP.7579.MA + SP.POP.80UP.MA)) %>% mutate(cardiovascular_deaths=(cardiovasc_death_rate * population)) %>% mutate(diabetes_pop_60_69=(diabetes_prevalence * (SP.POP.6569.MA + SP.POP.6569.FE)))
completeDataTable <- compleDataTable %>% select(iso_code, date, new_deaths_smoothed_2wk,new_deaths_smoothed, sort(names(.)))

# Split into Training and Test Splits
training_set <- completeDataTable %>% filter(date >= as.Date("2022-12-18") & date <= as.Date("2022-12-31"))
test_set <- completeDataTable %>% filter(date >= as.Date("2023-01-01") & date <= as.Date("2023-06-30"))

# Fit Five Models and Calculate their RSME
# Model 1
model1 <- lm(new_deaths_smoothed_2wk ~ population_density + new_people_vaccinated_smoothed + diabetes_pop_60_69 + SP.POP.65UP.TOTL + cardiovascular_deaths + new_cases_smoothed, data=training_set)

# Coefficients and Residuals
m1coef <- coef(model1)
m1 <-residuals(model1)

# Histogram of Residuals
train_model1 <- training_set %>% add_residuals(model1)
ggplot(data=train_model1) + geom_histogram(mapping=aes(x=resid))
#Plot the Residuals
ggplot(data=train_model1) + geom_point(mapping=aes(x=population_density + new_people_vaccinated_smoothed + diabetes_pop_60_69 + SP.POP.65UP.TOTL + cardiovascular_deaths + new_cases_smoothed, y=resid))

#Model Predictions
predictions_model1 <- predict(model1, newdata = test_set)
#R^2
m1R2 <- summary(model1)$r.squared
#RMSE
rmse_model1 <- sqrt(mean(((predictions_model1-test_set$new_deaths_smoothed)^2), na.rm = TRUE))

# Model 2
model2 <- lm(new_deaths_smoothed_2wk ~ new_vaccinations_smoothed + new_people_vaccinated_smoothed + handwashing_facilities + SP.POP.TOTL + new_cases_smoothed, data=training_set)

# Coefficients and Residuals
m2coef <- coef(model2)
m2 <-residuals(model2)

# Histogram of Residuals
train_model2 <- training_set %>% add_residuals(model2)
ggplot(data=train_model2) + geom_histogram(mapping=aes(x=resid))
#Plot the Residuals
ggplot(data=train_model2) + geom_point(mapping=aes(x=new_vaccinations_smoothed + new_people_vaccinated_smoothed + handwashing_facilities + SP.POP.TOTL + new_cases_smoothed, y=resid)) + geom_abline()

#Model Predictions
predictions_model2 <- predict(model2, newdata = test_set)
#R^2
m2R2 <- summary(model2)$r.squared
#RMSE
rmse_model2 <- sqrt(mean(((predictions_model2-test_set$new_deaths_smoothed)^2), na.rm = TRUE))

# Model 3
model3 <- lm(new_deaths_smoothed_2wk ~ extreme_poverty + new_cases + population_density + diabetes_prevalence + SP.POP.65UP.TOTL, data=training_set)

# Coefficients and Residuals
m3coef <- coef(model3)
m3 <-residuals(model3)

#R^2
m3R2 <- summary(model3)$r.squared

# Histogram of Residuals
train_model3 <- training_set %>% add_residuals(model3)
ggplot(data=train_model3) + geom_histogram(mapping=aes(x=resid))

#Plot the Residuals
ggplot(data=train_model3) + geom_point(mapping=aes(x=extreme_poverty + total_cases + population_density + total_deaths + SP.POP.65UP.TOTL, y=resid)) + geom_abline()

#Model Predictions
predictions_model3 <- predict(model3, newdata = test_set)

#RMSE
rmse_model3 <- sqrt(mean(((predictions_model3-test_set$new_deaths_smoothed)^2), na.rm = TRUE))

# Model 4
model4 <- lm(new_deaths_smoothed_2wk ~ SP.POP.65UP.TOTL + cardiovasc_death_rate + diabetes_prevalence + female_smokers + male_smokers + extreme_poverty, data=training_set)

# Coefficients and Residuals
m4coef <- coef(model4)
m4 <-residuals(model4)

# Histogram of Residuals
train_model4 <- training_set %>% add_residuals(model4)
ggplot(data=train_model4) + geom_histogram(mapping=aes(x=resid))
#Plot the Residuals
ggplot(data=train_model4) + geom_point(mapping=aes(x=extreme_poverty + total_cases + population_density + total_deaths + SP.POP.65UP.TOTL, y=resid)) + geom_abline()

#Model Predictions
predictions_model4 <- predict(model4, newdata = test_set)
#R^2
m4R2 <- summary(model4)$r.squared
#RMSE
rmse_model4 <- sqrt(mean(((predictions_model4-test_set$new_deaths_smoothed)^2), na.rm = TRUE))

# Model 5
model5 <- lm(new_deaths_smoothed_2wk ~ SP.POP.65UP.MA + cardiovasc_death_rate + diabetes_prevalence + male_smokers + population_density, data=training_set)

# Coefficients and Residuals
m5coef <- coef(model5)
m5 <-residuals(model5)

# Histogram of Residuals
train_model5 <- training_set %>% add_residuals(model5)
ggplot(data=train_model5) + geom_histogram(mapping=aes(x=resid))
# Plot the Residuals
ggplot(data=train_model5) + geom_point(mapping=aes(x=extreme_poverty + total_cases + population_density + total_deaths + SP.POP.65UP.TOTL, y=resid))

# Model Predictions
predictions_model5 <- predict(model5, newdata = test_set)
#R^2
m5R2 <- summary(model5)$r.squared

#RMSE
rmse_model5 <- sqrt(mean(((predictions_model5-test_set$new_deaths_smoothed)^2), na.rm = TRUE))

#Table of R2 and RMSE of all Models
modelReport <- tibble(
                        Models = c("Model 1", "Model 2", "Model 3", "Model 4", "Model 5"),
                        R2 = c(m1R2, m2R2, m3R2, m4R2, m5R2),
                        RMSE = c(rmse_model1, rmse_model2, rmse_model3, rmse_model4, rmse_model5),
                      )

modelReport %>% View()
# With the Top Model (model 1) Calculate the RMSE for Each Country (Get the top 20)
top_country_set <- test_set %>% group_by(iso_code, location, population) %>% summarise(RMSE=rmse(model=model1, data=cur_data())) %>% arrange(-population)
top_country_set <- top_country_set %>% select(-population) %>% slice_head(n=20)

top_country_set %>% View()
# Group Data by Country
country_data <- test_set %>% filter(date == as.Date("2023-06-30")) %>% group_by(location) %>% summarise(new_deaths_smoothed_2wk, new_cases_smoothed)
ggplot(country_data, mapping = aes(x = new_cases_smoothed, y = new_deaths_smoothed_2wk)) +
  geom_point() +
  labs(
    title = "Scatterplot of New Deaths 2 Weeks Ahead vs. New Cases Smoothed",
    x = "New Cases Smoothed",
    y = "New Deaths Smoothed 2 Weeks Ahead"
  ) +
  theme_minimal()

country_data <- test_set %>% filter(date == as.Date("2023-06-30")) %>% mutate(SP.POP.80UP.TOTL=(SP.POP.80UP.FE + SP.POP.80UP.MA)) %>% summarise(new_deaths_smoothed, SP.POP.80UP.TOTL)
ggplot(country_data, mapping = aes(x = SP.POP.80UP.TOTL, y = new_deaths_smoothed)) +
  geom_point() +
  labs(
    title = "Scatterplot of New Death vs. Population Over 80 Years Old",
    x = "Population Over 80 Years Old",
    y = "New Deaths Smoothed"
  ) +
  theme_minimal()

summary(model1)
