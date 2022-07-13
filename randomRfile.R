

library(tidyverse)
library(lubridate)
library(scales)
library(clipr)
library(janitor)
library(rvest)
# library(plyr)
# library(stringr)
# library(ggrepel)
# library(ggthemes)

# library(kableExtra)
# library(fuzzyjoin)
# library(waffle)

vulns_21 <- read_csv("input_datasets/raw_database.zip") %>%
  clean_names()
vulns_20 <- read_csv("input_datasets/dataframe_definitive_20210202.zip")

forces_ds <- read_csv("input_datasets/old_2021/dataframe_forces_20210127.zip")
groups_ds <- read_csv("input_datasets/dataframe_groups_20210204.csv")
rules_ds <- read_csv("input_datasets/findings_rules_map_std_2.csv")

groups_new <- read_csv("input_datasets/df_groups2022.csv")


# DevSecOps Agent ---------------------------------------------------------

agent1 <- read_csv("input_datasets/forces-dataset-Report6-2022-05-02-08 15-final.csv")

agent2 <- read_csv("input_datasets/forces-info-2022-05-02-08 36.csv")

count_forces <- agent2 %>%
  filter(date_datetime > "2020-10-31", date_datetime < "2021-11-01") %>%
  group_by(subscription_str, kind_str) %>% 
  summarize(total = n())
  
count_forces2 <- agent2 %>%
  filter(date_datetime < "2021-10-31") %>%
  mutate(date_datetime = as.Date(date_datetime)) %>% 
  group_by(subscription_str) %>% 
  summarize(total = n(),
            min_date = min(date_datetime),
            max_date = max(date_datetime),
            month_n = interval(ymd(min_date),ymd(max_date)) %/% months(1) + 1,
            ratio = total/month_n) %>% 
  filter(max_date > "2020-10-31")


