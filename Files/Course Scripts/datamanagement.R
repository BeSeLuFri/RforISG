#' ---
#' title: "Datamanagement"
#' ---
#' 
## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,warning = FALSE)

#' 
#' Download the script here [here](https://raw.githubusercontent.com/BeSeLuFri/RforISG/master/data/datamanagement.R)
#' 
#' # Preliminary:
#' 
#' * We use an old (2003) randomly changed and subsetted SOEP dataset with 5.000 observations. 
#' 
#' * Please, **download** the two csv files ([.soep_europ.csv](https://raw.githubusercontent.com/BeSeLuFri/RforISG/master/data/soep_europ.csv) and [soep_us.csv](https://raw.githubusercontent.com/BeSeLuFri/RforISG/master/data/soep_us.csv)) and the [soep.dta](https://github.com/BeSeLuFri/RforISG/raw/master/data/soep.dta) file and save them locally within your R project directory.
#' 
#' ***
#' 
#' # Load the packages and set-up the script
#' 
#' * To make sure that your R environment is clear, remember to use `rm(list=ls())` in the beginning. 
#' 
#' * As explained before, R itself can operate only very basic tasks and needs packages to run more powerful functions. 
#' 
#'   + Therefore, you should always load the packages you need in the beginning, too. 
#'   
#'   + When you are writing a script and discover that you need a new package, make sure to scroll back to the beginning and (install and) open the package there.
#'   
#'   + Throughout this page, we'll introduce the powerful [tidyverse](https://www.tidyverse.org/)) - a collection of very useful packages.
#' 
#' This is how the beginning of every of your scripts should look like: 1. Clean environment and 2. load packages  
## ---- message=FALSE------------------------------------------------------
rm(list = ls())
# install.packages("tidyverse")
library(tidyverse)

#' 
#' ***
#' 
#' # Loading the Dataset
#' 
#' Step 1 of Data Management is about "reading" the data into the R environment. 
#' There are many different file types and with R you can open all of them.
#' 
#' Here, we'll focus on two file types (csv and dta). Different data files require different approaches but  - **as always** - information can be easily accessed in the CRAN documentation/stackoverflow. 
#' 
#' Let's first open the csv fiel "soep_europ.csv". 
#' 
#' **Remember**: 
#' 
#' * You have to write down the path where the file is saved relative to the root.directory of your RProject.
#' 
#' * A good rule of thumb is to save all your data in a seperate "data" folder within your R environment: E.g. "data**/**soep_europ.csv"
#' 
#' * Don't use the backslash but always the forward slash(/). 
#' 
#' <span style="color:red">Task</span> <u>**Complete the empty spaces!**</u>
## ---- eval=FALSE---------------------------------------------------------
## data <- read.csv("_______") # Looks weird....
## 

#' 
#' What happened: In (most) European countries the standard way to save csv/excel files is to seperate values by ";" and the decimals by ",".
#' 
#' In the US and many other countries seperation is done by "," and the decimals are marked by ".". This is the default for read.csv. 
#' 
#' To read the data correctly, we have to add the argument "sep" to the function.
#' 
#' <span style="color:red">Task</span> <u>**Complete the empty spaces!**</u>
## ---- eval=FALSE---------------------------------------------------------
## data <- _____("data/soep_europ.csv", sep="_____") #

#' 
#' 2 Addenda: 
#' 
#' <span style="color:red">Task</span> <u>**1. Try out to to read a US style csv with soep_us.csv**</u>
## ---- eval=FALSE---------------------------------------------------------
## data <-

#' 
#' 2. An easier way to read European style csv files is to use `read_csv2()` from the tidyverse. 
#' 
#' <span style="color:red">Task</span> <u>**Use read_csv2() to read soep_europ.csv**</u>
## ---- eval=FALSE---------------------------------------------------------
## data <-

#' 
#' # DTA
#' * As a second data file type, we try to read dta (Stata's propietary file format)
#'   
#'   + If you only intend to use a package once, you can simply call the package with `packagename::function`.  
#' 
## ---- eval=FALSE---------------------------------------------------------
## # Laden des Datensatzes
## # install.packages("readstata13")
## library(readstata13)
## 
## #Daten als Objekt importieren
## data <- readstata13::read.dta13(file="data/soep.dta" ,
##                    convert.factors=FALSE, # default is TRUE, would create Stata value labels
##                    )
## 

#' 
#' Enough on reading data for now, let's use the European csv for now.
#' 
## ---- eval=FALSE---------------------------------------------------------
## data <- read_csv2("data/soep_europ.csv")

#' 
#' 
#' ***
#' 
#' # Select the relevant variables
#' Our data has 902 variables. Obviously, we do not need that many. 
#' 
#' Accordingly, we `select` the relevant ones:
#' 
#' * *gebjahr*, *sex*, *tp72* (Work Overtime), *tp7001* (Contracted Working Hours), *tp7003* (Hours Per Week Actual), *tp7602* (Net Income Last Month)
#' 
#' <span style="color:red">Task</span> <u>**Complete the empty spaces!**</u> Notice that after typing the first two or three characters of each variable, RStudio gives you a drop down menu. 
## ---- eval=FALSE---------------------------------------------------------
## data <- data %>% # remember the pipe?
##   select(______) # fill in the missing names

#' 
#' `select()` is from the tidyverse, namely the package `dplyr`. "dplyr is a grammar of data manipulation, providing a consistent set of verbs that help you solve the most common data manipulation challenges" [check this out](https://dplyr.tidyverse.org/)
#' 
#' ***
#' 
#' # Explore the data structure
#' 
#' For a first overview over our data, we can use the base functions (e.g. those which are without any package installations part of R) `str()`, `head()`, `summary()`, `table()`, `quantile()`, and `View()`.
#' 
#' <span style="color:red">Task</span> <u>**Go through every function's output and try to understand what it means!**</u>
## ---- eval=FALSE---------------------------------------------------------
## str(data)
## head(data)
## summary(data)
## table(data$tp72) # you could use any other variable here.
## quantile(data$tp72, na.rm = TRUE)
## View(data)

#' 
#' ***
#' 
#' # Basic Recoding and mutate()
#' 
#' The dataset is from 2003. Compute the age accordingly by creating the new variable age
#' 
#' <span style="color:red">Task</span> <u>**Complete the empty spaces!**</u>
## ---- eval=FALSE---------------------------------------------------------
## 
## data$age <- 2003 - _____
## 

#' 
#' There is also a dplyr way to do this: `mutate()`. 
#' 
#' <span style="color:red">Task</span> <u>**Complete the empty spaces!**</u>
## ---- eval=FALSE---------------------------------------------------------
## data <- ______ %>%
##   mutate(age = ______)

#' 
#' 
#' The benefit of this function is that you can easily apply more than one operation (on the same variable) at once in a tidy way. For example, let's say we 
#' 
#' * want to recode the binary variable tp72 (Work Overtime) into three levels: 
#' 
#'   + 10 Yes
#'   
#'   + 20 No
#'   
#'   + 0 Everything else
#' 
#' * Apply those changes to tp72 by creating the new variable over
#' 
#' * Do someting similar with tp7602 (recreate as netinc, change specific values to NA)
#' 
#' <span style="color:red">Task</span> <u>**Complete the empty spaces!**</u>
## ---- eval=FALSE---------------------------------------------------------
## data <- data %>%
##   mutate(
##     over = recode(
##       tp72,
##       "3" = 0, #actually means Does not apply: Self-Employment
##       "-2" = 0, # actually means does not apply
##       "-1" = 0, # actually means no answer
##       .default = tp72
##     ),
##     over = over * 10,
##     netinc = ____(
##       _____,
##       "-3" = NA_real_, # remember the difference between integer and double?
##       "-2" = NA_real_,
##       "-1" = NA_real_
##     )
##   )
## 

#'  
#'  Several things to note here:
#'  
#'  * Within the same function (mutate) using the same variable (over), we have applied to different functions (recode and multiplying the values by 20). 
#'  
#'  * Within `mutate()` we can - in a tidy way - work on multiple variables (e.g. over and netinc)
#'  
#'  * Why do we write an NA_real? Because R has to be explicitly told that the NA it should use as a replacement should be an of type double (see last page on the difference between double and integer).
#'  
#' Let's check whether the data manipulation worked:
#' 
## ---- eval=FALSE---------------------------------------------------------
## 
## table(data$over)
## 
## table(data$over,
##       useNA = "always") # we add the argument useNA in order to also get the number of NA values.

#' 
#' ***
#' 
#' # Factorize 
#' 
#' As we have practiced before, we can factorize variables. This is also possible within the dplyr world (`mutate()` again). Let's do that for sex.
#' 
#' <span style="color:red">Task</span> <u>**Complete the empty spaces!**</u>
## ---- eval=FALSE---------------------------------------------------------
## 
## 
## _____ <- _____ _____
##   ____(sex = factor(
##     sex ,
##     levels = c(1, 2),
##     labels = c("male", "female")
##   ))

#' 
#' ***
#' 
#' # Recode II
#' 
#' We can also recode values below a certain threshold at once (if it is numeric (either double or integer)): 
#' 
#' `if_else(condition, true, false)`
#' 
#' * tp7001(Contracted Working Hours): mutate as "contract", change all values below 0 (errors) to NA, and divide the variable 
#' * Do the same for tp7003: Actual working hours
#' 
## ---- eval=FALSE---------------------------------------------------------
## data <- data %>%
##   mutate(
##     contract =
##       if_else(tp7001 < 0, NA_real_, tp7001),
##     actual =
##       ____(__________________________________),
##     contract = contract / 10,
##     actual = _______________
##   )

#' 
#' ***
#' 
#' # Multiple if_else() statements: 
#' 
#' `cases_when()` allows us to apply multiple `if_else()` statements. 
#' 
#' Let's say, we want to build a character variable inc.quant which indicates the `quantile()` (see above) of netinc. 
#' 
#' <span style="color:red">Task</span> <u>**Complete the empty spaces!**</u>
## ---- eval=FALSE---------------------------------------------------------
## 
## data <- data %>%
##   mutate(
##     inc.quant = case_when(
##       netinc < quantile(netinc, na.rm = TRUE)[2] ~ "Q1",
##       netinc >= quantile(netinc, na.rm = TRUE)[2] &
##         netinc < quantile(netinc, na.rm = TRUE)[3] ~ "Q2",
## 
##       netinc >= quantile(netinc, na.rm = TRUE)[__] &
##         netinc < _______(netinc, na.rm = TRUE)[__] ~ "Q3",
## 
##       netinc ______________________________________
##     )
##   )
## 

#' 
#' 
#' # Check data.frame again
#' 
## ---- eval=FALSE---------------------------------------------------------
## head(data)
## summary(data)

#' 
#' # All in one
#' By the way, we could have done all of this in one batch - but it would have been untidy... 
## ---- message=FALSE------------------------------------------------------
data <- read_csv2("data/soep_europ.csv")

data <- data %>% # remember the pipe?
  select(gebjahr, sex, tp72, tp7001, tp7003 , tp0301, tp0302, tp7602) %>% # fill in the missing names
  
  mutate(age = 2003-gebjahr, 
         
         over = recode(
           tp72,
           "3" = 0, #actually means Does not apply: Self-Employment
           "-2" = 0, # actually means does not apply
           "-1" = 0, # actually means no answer
           .default = tp72
          ),
         over = over * 10,
         netinc = recode(tp7602,
                         "-3" = NA_real_,
                         "-2" = NA_real_,
                         "-1" = NA_real_
          ),
         
         sex = factor(
           sex ,
           levels = c(1, 2),
           labels = c("male", "female")
         ),    
         
         contract =
           if_else(tp7001 < 0, NA_real_, tp7001),
         actual =
           if_else(tp7003 < 0, NA_real_, tp7003),
         contract = contract / 10,
         actual = actual / 10,

         inc.quant = case_when(
           netinc < quantile(netinc, na.rm = TRUE)[2] ~ "Q1",
           netinc >= quantile(netinc, na.rm = TRUE)[2] &
             netinc < quantile(netinc, na.rm = TRUE)[3] ~ "Q2",
           netinc >= quantile(netinc, na.rm = TRUE)[3] &
             netinc < quantile(netinc, na.rm = TRUE)[4] ~ "Q3",
           netinc >= quantile(netinc, na.rm = TRUE)[4] ~ "Q4"
         )
  )


#' 
#' Great job! We are almost done. 
#' 
#' Below we'll QUICKLY introduce a few more functions.
#' 
#' ***
#' 
#' # Summarise
#' 
#' Summarise allows us to summarise certain variables, such as certain features of age 
#' 
## ---- eval=FALSE---------------------------------------------------------
## 
## data %>%
##   summarise(mean = mean(age, na.rm = TRUE),
##             sd = sd(age, na.rm = TRUE))

#' 
#' ***
#' 
#' # Grouping
#' 
#' The same is also possible for grouped structures. Say, for example, you would want to calculate seperate values for different genders: 
#' 
## ---- eval=FALSE---------------------------------------------------------
## 
## data %>%
##   group_by(sex) %>%
##   summarise(mean = mean(age, na.rm = TRUE),
##             sd = sd(age, na.rm = TRUE))
## 

#' 
#' A bit more nuanced, let's say you want to create a variable cohort.deviance which gives you the deviation in netinc from the mean of all people of the same age
#' 
#' <span style="color:red">Task</span> <u>**Complete the empty spaces!**</u>
## ---- eval=FALSE---------------------------------------------------------
## data <- data %>%
##   _________ %>%
##   mutate(cohort.deviance = netinc - ______(_______, na.rm = TRUE))

#' 
#' 
#' ***
#' 
#' # Filtering
#' 
#' If you only want to keep certain rows (observations) which variables match a certain criterion, you can `filter()`. 
#' 
#' Let's say, you only want to keep those observations which are older than 18 and who are in the top three income quintiles. We store this in data2
#' 
#' <span style="color:red">Task</span> <u>**Note the difference between the lines of inc.quant and sex!**</u>
## ---- eval=FALSE---------------------------------------------------------
## data2 <- data %>%
##   filter(age > 18,
##          inc.quant %in% c("Q2", "Q3", "Q4"),
##          sex == "male")

#' 
#' When we filter for exactly one condition, we use `==`. When we filter for a string, we use `%in%`
#' 
#' ***
#' 
#' # Arrange
#' Sometimes, we want to order data. We do so with `arrange()`.
#' 
#' <span style="color:red">Task</span> <u>**What is the difference between the two examples?**</u>
## ---- eval=FALSE---------------------------------------------------------
## # Example 1
## data <- data %>%
##   arrange(desc(age))
## 
## head(data)
## 
## # Example 2
## data <- data %>%
##   group_by(inc.quant) %>%
##   arrange(netinc, .by_group=TRUE)
## 
## head(data)

#' 
#' # Merge()
#' @BF: Hier Weiter machen.
#' Assuming, we forgot the variable 
#' 
## ------------------------------------------------------------------------
data <- read_csv2("data/soep_europ.csv")


#' 
#' - merge()
#' - spread, und xx
