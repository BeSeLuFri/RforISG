## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,warning = FALSE)


## ---- echo=FALSE, message=FALSE------------------------------------------
rm(list = ls())
library(tidyverse)


## ---- eval=FALSE---------------------------------------------------------
## eurost <-
## 
## # filter for the time==2014
## 


## ---- echo=FALSE, warning=FALSE, message=FALSE---------------------------
eurost <- read_csv2("data/eurostat_data.csv")

eurost <- eurost %>%
  filter(time==2014)

ggplot(
  data = eurost,
  mapping = aes(
    x = unemp_youth_t,
    y = gdp_gr,
    color = emmigration_t / immigration_t)
) +
  geom_point(
    aes(size = inv_per_empl)
  ) +
  labs(x = "Share of Unemployed Youth (15-24) in Pct.",
       y = "Real GDP growth rate (YOY)",
       title = "GDP growth and youth unemployment in 2014",
       subtitle = "Correlation between lower growth rate and higher youth unemployment",
       caption = "Source: Eurostat",
       size = "Investment p. person\n employed (in Mill. €)",
       color= "Ratio of Emmigration \n to Immigration")+
  geom_smooth(method="lm", se=FALSE, color="black")+
  theme_classic()


## ---- echo=FALSE---------------------------------------------------------
ggplot(
  data = eurost,
  mapping = aes(x = geo_code, y = unemp_youth_t, fill = unemp_youth_t)
) +
  geom_bar(stat = "identity", width = 0.7) +
  geom_point(mapping = aes(y = unemp_workagepop_t, color = "red"),
             size = 3) +
  labs(
    title = "Unemployment levels of youth and total working age population",
    subtitle = "In most European countires youth unemployment is almost twice as big",
    x = "Countries",
    y = "Unemployment (in Pct.)",
    fill = "Youth unemployment",
    color = "Total unemployment",
    caption = "Source: Eurostat, Data from 2014"
  ) +
  scale_color_manual(values = c("red"), labels = c(" ")) +
  ggthemes::theme_economist()


## ---- message=FALSE, warning=FALSE---------------------------------------
eurost2 <- read_csv2("data/eurostat_data.csv") %>%
  filter(geo_code %in% c("DE", "IT", "EL", "ES", "UK"),
         time>=1990,
         time<=2015) %>%
  mutate(unemp_tod = if_else(time==2015, unemp_workagepop_t, NA_real_),
         unemp_youth_tod = if_else(time==2015, unemp_youth_t, NA_real_))


## ---- echo=FALSE---------------------------------------------------------

ggplot(data = eurost2,
       mapping = aes(x = geo_code)) +
  geom_violin(mapping = aes(y = unemp_youth_t, fill = "red"),
              alpha = 0.5) +
  geom_violin(mapping = aes(y = unemp_workagepop_t, fill = "blue"),
              alpha = 0.5) +
  geom_point(aes(y = unemp_tod), color = "black", size = 3) +
  geom_point(aes(y = unemp_youth_tod), color = "black",  size = 3) +
  theme_minimal() +
  labs(
    title = "Unemployment levels of youth and total working age population \n Histogram of values between 1990 and 2015)",
    subtitle = "Germany is the only country (in comparison) where youth unemployment and \n total unemployment have moved within the same corridor historically",
    x = "Countries",
    y = "Unemployment (in Pct.)",
    fill = "Unemployment \n (2015 as point)",
    caption = "Source: Eurostat"
  )+
  scale_fill_manual(values = c("red", "blue"), labels = c("Total Unemployment", "Youth Unemployment"))


## ------------------------------------------------------------------------
main_plot <- ggplot(
  data = eurost,
  mapping = aes(
    x = unemp_youth_t,
    y = gdp_gr,
    color = emmigration_t / immigration_t)
) +
  geom_point(
    aes(size = inv_per_empl)
  ) +
  labs(x = "Share of Unemployed Youth (15-24) in Pct.",
       y = "Real GDP growth rate (YOY)",
       title = "GDP growth and youth unemployment in 2014",
       subtitle = "Correlation between lower growth rate and higher youth unemployment",
       caption = "Source: Eurostat",
       size = "Investment p. person\n employed (in Mill. €)",
       color= "Ratio of Emmigration \n to Immigration")+
  geom_smooth(method="lm", se=FALSE, color="black")+
  theme_classic()


## ------------------------------------------------------------------------
main_plot


## ---- echo=FALSE---------------------------------------------------------
main_plot+
   scale_color_gradient2(
    midpoint = 1,
    low = "blue",
    mid = "lightgrey",
    high = "red",
    space = "Lab"
    )


## ---- echo=FALSE---------------------------------------------------------
main_plot+
  ggrepel::geom_text_repel(mapping = aes(label=geo_code))



## ---- echo=FALSE---------------------------------------------------------
main_plot+
  facet_wrap(~location)+
  labs(caption = "Source: Eurostat + location is manully defined by the site's creator")



## ---- message=FALSE------------------------------------------------------
# Download the plotly package:

library(plotly)

ggplotly(p = main_plot)


