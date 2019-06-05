data_a <-
  get_eurostat(id = "lfsa_ergaed", # the relevant id to be downloaded
               time_format = "num") # retrieve time column as.numeric right away (bc we only have yearly data)

data_a <- label_eurostat(data_a,
                         code = c("geo",
                                  "isced11",
                                  "sex"), # we want to keep the "geo" plus relevant identifier items to be able to merge data easily
                         lang = "en") # English is the default, line included for transparency

data_a <- data_a %>%
  filter(age == "From 15 to 64 years",
         # filter for appropriate values --> if more variables (for example sex or age) are needed, make changes here!
         isced11_code %in% c("ED0-2", "ED3_4", "ED5-8")) %>%
  mutate(
    variab = "emp", # Add variable identifier
    isced11_code = str_replace(isced11_code, "-", "_"),
    # R doesn't like '-'(minus) in column names, change that to '_'
    key = paste(variab, isced11_code, sex_code, sep = "_")
  ) %>% # Merge sex and isced to get different data vars
  select(-c(unit, sex, isced11, sex_code, isced11_code, age, geo)) %>% # remove unnecessary rows (which would be in the way of spread)
  spread(key = key, value = values) %>% # spread out the column whose individual levels are needed as columns
  rename_all(tolower) # all column names in lowercase