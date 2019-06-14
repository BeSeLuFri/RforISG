#Daten als Objekt importieren
econ <- readstata13::read.dta13(file="data/offline/econometrics.dta" ,
                   convert.factors=F,
                   nonint.factors = F)

# Subsample with 5000 Observations
econ <- econ [sample(c(1:nrow(econ)),size = 5000,replace = FALSE),]

# Randomly add NA values
econ2 <- data.frame(lapply(econ, function(cc) cc[ sample(c(TRUE, NA), prob = c(0.75, 0.25), size = length(cc), replace = TRUE) ]))

# Clean Gebjahr (easier for the logic of the Tut) AND keep only distinct hhnr and persnr rows (for merge)
econ2 <- econ2 %>%
  mutate(gebjahr = recode(gebjahr, "-1"=NA_integer_)) %>%
  distinct(hhnr, persnr, .keep_all = TRUE)

write_csv(econ2, "data/soep_us.csv")

write_csv2(econ2, "data/soep_europ.csv")

haven::write_dta(econ2, "data/soep.dta")

haven::write_sav(econ2, "data/soep.sav")

openxlsx::write.xlsx(econ2, "data/soep.xlsx")

