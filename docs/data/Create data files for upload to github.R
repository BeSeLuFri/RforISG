#Daten als Objekt importieren
econ <- read.dta13(file="data/offline/econometrics.dta" ,
                   convert.factors=F,
                   nonint.factors = F)

# Subsample with 5000 Observations
econ <- econ [sample(c(1:nrow(econ)),size = 5000,replace = FALSE),]

# Randomly add NA values
econ2 <- data.frame(lapply(econ, function(cc) cc[ sample(c(TRUE, NA), prob = c(0.75, 0.25), size = length(cc), replace = TRUE) ]))

# Clean Gebjahr (easier for the logic of the Tut)
econ2 <- econ2 %>%
  mutate(gebjahr = recode(gebjahr, "-1"=NA_integer_))

write_csv(econ2, "data/soep_us.csv")

write_csv2(econ2, "data/soep_europ.csv")

foreign::write.dta(econ2, "data/soep.dta")


