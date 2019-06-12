#' ---
#' title: "Datamanagement: Eurostat Example"
#' ---
#' 
## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,warning = FALSE)

#' 
#' Download the script [here](https://raw.githubusercontent.com/BeSeLuFri/RforISG/master/Files/Course%20Scripts/datamanagement_eurostat.R)
#' 
#' # General
#' 
#' # Info about the Eurostat API and the general approach. 
#'    
#' ## General Coding Information
#' * Retrieve and manage data for the PES project directly via the Eurostat API and the related eurostat R package 
#' * Links: [eurostat Cheat Sheet](https://github.com/rstudio/cheatsheets/raw/master/eurostat.pdf) and  [eurostat Documentation](https://cran.r-project.org/web/packages/eurostat/eurostat.pdf)
#' 
#' ## Important Data Management Decisions
#' * For Belgium regions the following geo identifiers have been used
#'   + **BE1** Région de Bruxelles-Capitale / Brussels Hoofdstedelijk Gewest --> ATTENTION BE10 seems to be identical
#'   + **BE2** Vlaams Gewest
#'   + **BE3** Région wallonne
#' * Youth and working age population
#'   + Youth defined as "From 15 to 24 years"
#'   + Working age populations as "From 15 to 64 years",
#'   
#' ## The data management structure
#' * Each variable/group of related variables has its own header and is downloaded and manipulated in the same fashion:
#'   + There are three code chunks: one for a) all countries, b) Belgian regions and c) merging a and b
#' * a) and b) themselves have the same order:
#'   + Download data via API with get_eurostat
#'   + Label all codes (for easier readability) with label_eurostat
#'   + Filter, select and spread the data
#' * The first data group (Employment) has extensive comments to ease the understanding of the code
#' * To retrieve the eurostat codes for datasets check the subchapter "Search for Eurostat codes"
#'   
#' 
#' ## Load packages
#' * If you haven't done so already, install all the packages below with install.packages("packagename") 
## ----message=FALSE, warning=FALSE----------------------------------------
library(tidyverse) # the state of the art system of packages for data manipulation, exploration and visualization with a a coherent design philosophy
library(eurostat) # the propietary eurostat package for retrieving and manipulating Eurostat data

#' 
#' 
#' ## Clean Environment/Cache 
#' * Eurostat saves all the data we download via the eurostat package in C:\Users\Username\Temp and reloads them from there every time you rerun the get_eurostat function
#'   + This might lead to datasets remaining "unupdated" if we accidentially reload the data from local user and not the API. 
#'   + therefore, always run clean_eurostat_cache() before new sessions
## ---- message=FALSE------------------------------------------------------
rm(list = ls()) # The standard environment cleaner for your R environment
# clean_eurostat_cache() # see bullet points above 

#' 
#' ## Search for Eurostat codes
#' * Eurostat codes for data tables can be retrieved via search_eurostat
#' * An example (looking for all data containing the name employment in the title):
## ---- message=FALSE------------------------------------------------------
query <- search_eurostat("Employment",
                         type = "all") # inspect query via View(query)

#' 
#' 
#' # Employment rate by educational attainment levels
#' ## Countries: **lfsa_ergaed** Employment rates by sex, age and educational attainment level 
## ---- message=FALSE------------------------------------------------------
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
  


#' 
#' ## Belgium: **lfst_r_lfe2emprtn** Employment rates by sex, age, educational attainment level, citizenship and NUTS 2 regions
## ---- message=FALSE------------------------------------------------------
data_b <-
  get_eurostat(id = "lfst_r_lfe2emprtn", # the relevant id to be downloaded
               time_format = "num") # retrieve time column as.numeric right away (bc we only have yearly data)


data_b <- label_eurostat(
  data_b,
  code = c("geo",
           "isced11",
           "sex"),
  # we want to keep the "geo" and "na_item" column to be able to merge data easily
  lang = "en",
  # English is the default, line included for transparency
  fix_duplicated = TRUE
)

data_b <- data_b %>%
  filter(
    geo_code %in% c("BE1", "BE2", "BE3"),
    citizen == "Total", # geo_code and citizen are the only two differences in Belgium compared to Country level for the filter
    age == "From 15 to 64 years",
    # filter for appropriate values --> if more variables (for example sex or age) are needed, make changes here!
    isced11_code %in% c("ED0-2", "ED3_4", "ED5-8")
  ) %>%
  mutate(
    variab = "emp", # Add variable identifier
    isced11_code = str_replace(isced11_code, "-", "_"),
    # R doesn't like '-'(minus) in column names, change that to '_'
    key = paste(variab, isced11_code, sex_code, sep = "_")
  ) %>% # Merge sex and isced to get different data vars
  select(-c(unit, sex, isced11, sex_code, isced11_code, age, geo, citizen)) %>% # remove unnecessary rows (which would be in the way of spread) + Do not forget also to unfilter citizen (extra variable in the Belgium data)
  spread(key = key, value = values) %>% # spread out the column whose individual levels are needed as columns
  rename_all(tolower) # all column names in lowercase



#' 
#' ## Rbind a and b
## ---- message=FALSE------------------------------------------------------
empl_educ <- rbind(data_a, data_b)

#' 
#' 
#' # Replacement Rate of last earnings before unemployment
#' * From OECD
#' * https://stats.oecd.org/Index.aspx?DataSetCode=NRR#_ga=2.115968198.1529179679.1559572370-478591159.1556266530
#' * Which time --> data different from the data in excel file ToDo @HV
## ---- message=FALSE------------------------------------------------------
# reprate <- read_csv("2019/orig/test/Replacement Rate last earnings.csv")

#' 
#' 
#' # Left over for Hans
#' * Share of self-employed (Var no 53)
#' * Duration of working life (Var no 54)
#' 
#' 
#' 
#' 
#' 
#' +++++++++++++++++++++
#' 
#' # Merge all df together and save as csv
## ---- message=FALSE------------------------------------------------------

# df_final <-
#   Reduce(
#     function(x, y)
#       full_join(x, y, by = c("geo_code", "time")),
#     list(empl_educ, unempl, empl_sex_age, transition, empl_growth, totemp, gdp_gr, gdp_pc, inv, min_wage, empsize, dropout,  
#          literacy, childcare, gr_productiv, popul, depratio, immigr, emmigr, tempemp, jobsrch, activtyrate, parttime, death)
#   )
# 
# df_final <- df_final %>%
#   group_by(geo_code, time) %>%
#   rename_all(tolower)

# write_excel_csv2(df_final, "data_uptodate.csv")

#' 
