library(tidyverse)

data <- readstata13::read.dta13(file="data/soep.dta" ,
                                convert.factors=FALSE, # default is TRUE, would create Stata value labels
) 

data <- read_csv2("data/soep_europ.csv")

data <- data %>% # remember the pipe?
  select(hhnr, persnr, gebjahr, sex, tp72, tp7001, tp7003 , tp0301, tp0302, tp7602)%>%
  mutate(age = 2003-gebjahr) %>%
  filter(age>=18) %>%
  arrange(desc(age))


data <- data %>%
  mutate(
    over = recode(
      tp72,
      "3" = 0, #actually means Does not apply: Self-Employment
      "-2" = 0, # actually means does not apply
      "-1" = 0, # actually means no answer
      .default = tp72
    ),
    over = over * 10,
    netinc = recode(
      tp7602,
      "-3" = NA_real_,
      "-2" = NA_real_,
      "-1" = NA_real_,
      .default = tp7602
    )
  )


data <- data  %>%
  mutate(sex = factor(
    sex ,
    levels = c(1, 2),
    labels = c("male", "female")
  ))


data <- data %>%
  mutate(
    contract =
      if_else(tp7001 < 0, NA_real_, tp7001),
    actual =
      if_else(tp7003 < 0, NA_real_, tp7003),
    contract = contract / 10,
    actual = actual / 10
  )


data <- data %>%
  mutate(
    inc.quant = case_when(
      netinc < quantile(netinc, na.rm = TRUE)[2] ~ "Q1",
      netinc >= quantile(netinc, na.rm = TRUE)[2] &
        netinc < quantile(netinc, na.rm = TRUE)[3] ~ "Q2",
      netinc >= quantile(netinc, na.rm = TRUE)[3] &
        netinc < quantile(netinc, na.rm = TRUE)[4] ~ "Q3",
      netinc >= quantile(netinc, na.rm = TRUE)[4] ~ "Q4"
    )
  )

data <- data %>%
  group_by(age) %>%
  mutate(cohort.deviance = netinc - mean(netinc, na.rm = TRUE)) 

data.origin <- read_csv2("data/soep_europ.csv")

data <- data %>%
  left_join(data.origin[,c("hhnr", "tp0101", "persnr")], by=c("hhnr", "persnr"))

data.long <- data %>%
  gather(key=key, value = value, -c(hhnr, persnr))


data.wide <- data.long %>%
  spread(key=key, value=value)
