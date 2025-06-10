#ACS 2023 5-year estimates - 2019-2023
#Created - 06/09/2025

#Install packages
if (!requireNamespace("tidycensus", quietly = TRUE)) install.packages("tidycensus")
if (!requireNamespace("dplyr",      quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("tidyr",      quietly = TRUE)) install.packages("tidyr")

library(tidycensus)
library(dplyr)
library(tidyr)

#Add your key here
census_api_key("be1056a855b0fc0c9133e9685ebff35458937f91", install = FALSE)

# ACS5 2023 variables - includes both genders (total)
age_zcta_raw <- get_acs(
  geography = "zcta",
  variables = c("S0101_C01_002E", # age: under 5
    "S0101_C01_003E",# age: 5-9
    "S0101_C01_004E", # age: 10-14
    "S0101_C01_021E" # age: 15-17
  ),
  year     = 2023, 
  survey   = "acs5", #5-year ACS 2019-2023
  geometry = FALSE
)

# Wide format: one column per age variable, GEOID=ZCTA #
age_zcta_2023_acs5 <- age_zcta_raw %>%
  select(GEOID, NAME, variable, estimate) %>%
  pivot_wider(
    names_from  = variable,
    values_from = estimate
  )

head(age_zcta_2023_acs5)

out_path <- "//Users/you/your/path/age_zcta_2023_acs5.csv"
write.csv(age_zcta_2023_acs5,
          file      = out_path,
          row.names = FALSE)