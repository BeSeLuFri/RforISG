#' ---
#' title: "Objects and Data Frames"
#' ---
#' 
## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

#' 
#' Download the script here [here](https://raw.githubusercontent.com/BeSeLuFri/RforISG/master/Files/Course%20Scripts/objectsndata.R).
#' 
#' ***
#' 
#' # Objects in R
#' ## Basic Calculations
#' We will most often want to store results of calculations to reuse them later. For this, we can work with basic objects. An object has a name and a content. We can freely choose the name of an object and give certain rules - they have to start with a letter and include only letters, numbers and some special characters (".", "_", "-"). **R is case sensitive so "x" and "X" are different object names**.
#' 
#' The content of an object is assigned using "<-" or "=" (for tidy readability, you should always use the former, though).
#' 
#' In order to assign the value of 5 to an object with name x do 
## ------------------------------------------------------------------------
x <- 5
# Which corresponds to
x = 5

#' 
#' If you already had an object named x before and want to change it, you can simply overwrite the old version.
#' 
#' <span style="color:red">Task</span> <u>**Assign the value of 10 to the object x**</u>
## ----Assign the value of 10 to the object x, eval=FALSE------------------
## x

#' 
#' Similarly, you can use an object to create other objects. 
#' 
#' <span style="color:red">Task</span> <u>**Multiply x with 5 and save it as b**</u>
## ----Multiply x with 5 and save it as b, eval=FALSE----------------------
## b <-

#' 
#' <span style="color:red">Task</span> <u>**Print b by simply typing its name in the script**</u>
## ----Print b by simply typing its name in the script---------------------


#' 
#' In R Studio all the object names are also shown in the "Workspace" window on the top right side. 
#' 
#' If we want to delete certain objects we can do so with the function ```rm()``` (remove). ```rm(list=ls())``` removes all objects currently saved in the list environment.  
## ------------------------------------------------------------------------
# Change and Delete objects:
rm(x) # Deletes an object
rm(list=ls()) # all objects are removed

#' 
#' ***
#' ## Vectors
#' For statistical calculations, we obviously need to work with data sets including many numbers of instead of scalars. The simplest way to collect many numbers (or other tpyes of information) is called a vector in R terminology (you have already been familiarized with vectors on the page before). 
#' 
#' To define a vector, we can collect different values using ```c(value1, value2,...)```. 
## ------------------------------------------------------------------------
# Examples
a <- c(1, 2, 3, 4)

#' 
#' 
#' <span style="color:red">Task</span> <u>**Do you remember a different (easier) way to build the vector a?**</u>
## ---- eval=FALSE---------------------------------------------------------
## a <-

#' 
#' <span style="color:red">Task</span> <u>**What happens if we add 1 to a?**</u>
## ------------------------------------------------------------------------
b <- a + 1
b

#' 
#' R is object based coding --> it follows average math rules
## ------------------------------------------------------------------------
c <- sqrt(a + b * 2)
c

#' 
#' 
#' Important R functions for vectors:
#' 
#' <span style="color:red">Task</span> <u>**Do you understand all of these functions?**</u>
## ------------------------------------------------------------------------
# Important R functions for vectors:
# Basic functions:
sort(a)
length(a)
min(a)
max(a)
sum(a)
prod(a)

# Creating special vectors:
rep(1, 20)
seq(50)
5:15
seq(4, 20, 2)

#' 
#' ***
#' ### Logical Operators and Logical Vectors
#' 
## ----eval=FALSE----------------------------------------------------------
## x==y # x is equal to y
## x>y  # x is bigger then y
## x<=y # x is smaller or equal to y
## x!=y # x is NOT equal to y
## !b   # NOT b (i.e. b is FALSE)
## a|b  # Either a or b is TRUE
## a6b  # Both a and b are TRUE

#' The contents of R vectors do not need to be numeric. A simple example of a different type are character vectors. For handling them, the contents simply need to be enclosed in quotation marks:
## ------------------------------------------------------------------------
cities = c("Friedrichshafen", "Paris", "Tokio", "Tettnang", "Mailand")
cities

#' 
#' Another useful type are **logical vectors**. Each element can only take one of two values: "TRUE" or "FALSE". Internally, "FALSE" corresponds to 0 and "TRUE" to 1. 
#' 
## ------------------------------------------------------------------------
a <- c(7,2,6,9,4,1,3) 
b <- a<3 | a>=6 
b

#' As we have seen in Econometrics, many variables take only a binary outcome, e.g. they are a dummy variable (for example gender)
#' 
#' If we want to store qualitative information with more levels we can use so called **factors**. 
#' 
## ------------------------------------------------------------------------
# Costumer Ratings
x <- c(3,2,2,3,1,2,3,2,1,2)
xf <- factor(x, labels=c("bad","okay","good")) 
x
xf

#' ***
#' ### Naming and Indexing Vectors
#' The elements of a vector can be named which can increase the readability of the output. Given a vector vec and a string vector namevec of the same length, the names are attached to the vecotor elements using ```names(vec) = namevec```.
#' 
#' If we want to access a single element or a subset form a vecotr, we can work with indices. They are written in swquare brackets next to the vector name. For example ````myvector[4]``` returns the rth element of myvector and ```myvector[6] = 8``` changes the 6th element to take the value of 8. If the vector elements have names, we can also use those as indices like in ```myvector["elementname"]```
## ------------------------------------------------------------------------
# Create a vector "avgs":
avgs <- c(.366, .358, .356, .349, .346)

# Create a string vector of names:
players <- c("Cobb","Hornsby","Jackson","O'Doul","Delahanty")

# Assign names to vector and display vector:
names(avgs) <- players
avgs

# Indices by number:
avgs[2]
avgs[1:4]

# Indices by name:
avgs["Jackson"]

# Logical indices:
avgs[ avgs>=0.35 ]

#' 
#' ***
#' ## Matrices
#' Matrices are important tools for econometric analyses (think back to the first Tut). R has a powerful matrix algebra system. Most often in applied econometrics, matrices will be generated from an exisiting data set. But you can also build the from scratch with ```matrix(vec, nrow=m)``` (takes the numbers storeend in vector vec and puts them into a matrix with m rows). 
#' Other options incluede: ```rbind(r1,r2)``` and ```cbind(c1,c2)``` in binding several vectors (which obviously need to have the same length) by row or column.
#' 
## ------------------------------------------------------------------------
# Generating matrix A from one vector with all values:
v <- c(2,-4,-1,5,7,0)
A <- matrix(v,nrow=2) 
A

# Generating matrix A from two vectors corresponding to rows:
row1 <- c(2,-1,7); row2 <- c(-4,5,0)
A <- rbind(row1, row2)
A

# Generating matrix A from three vectors corresponding to columns:
col1 <- c(2,-4); col2 <- c(-1,5); col3 <- c(7,0)
A <- cbind(col1, col2, col3) 

# Giving names to rows and columns:
colnames(A) <- c("Alpha","Beta","Gamma")
rownames(A) <- c("Aleph","Bet") 
A

# Indexing for extracting elements (still using A from above):
A[2,1]
A[,2]
A[,c(1,3)]


# Direct multiplication (not matrix multiplication but multiplying elements at same place)
A <- matrix( c(2,-4,-1,5,7,0), nrow=2)
B <- matrix( c(2,1,0,3,-1,5), nrow=2)
A*B

# Transpose:
(C <- t(B) )

# Matrix multiplication:
(D <- A %*% C )

# Inverse:
solve(D)


#' 
#' ## Lists
#' A list is a generic collection of objects. Unlike vectors, components can be of different types.
## ------------------------------------------------------------------------
# Generate a list object:
mylist <- list( A=seq(8,36,4), this="that", idm = diag(3))

# Print whole list: 
mylist

# Vector of names:
names(mylist)

# Print component "A":
mylist$A

#' 
#' ***
#' ## Data Frames
#' A data frame is an object that collects several variables and can be thought of as a rectangular shape with the rows representing the observational units and the columns representing the variables. As such, it is similar to a matrix. For us, the most important difference to a matrix is that a data frame can contain variables of different types (like numerical, logical, string and factor), whereas matrices can only contain numerical values. 
#' 
#' Unlike a matrix, the columns alwways contain names which represent the variables. We can define a data frame from scratch by using the command ```data.frame``` or ```as. data.frame```
## ------------------------------------------------------------------------
# Define one x vector for all:
year     <- c(2008,2009,2010,2011,2012,2013)
# Define a matrix of y values:
product1<-c(0,3,6,9,7,8); product2<-c(1,2,3,5,9,6); product3<-c(2,4,4,2,3,2)
sales_mat <- cbind(product1,product2,product3)
rownames(sales_mat) <- year
# The matrix looks like this:
sales_mat

# Create a data frame and display it:
sales <- as.data.frame(sales_mat)
sales

#' The outputs of matrix ```sales_mat``` and ```sales``` look exactly the same, but they behave differently. In RStudio, the difference can be seen in the Workspace window. ```sales``` is desceibed as *6 obs. of 3 variables*.
#' ***
#' We can address a single variable var of a data frame df using the matrix-like syntax ```df[, "var"]``` or by stating ```df$var```. This can be used for extracting the values of a variable but also for creating new variables. Sometimes, it is convenient not to have to type the name of the data frame several times within a command. The function ```with(df, some expression using vars of df``` can help. 
## ------------------------------------------------------------------------
# Accessing a single variable:
sales$product2

# Generating a new  variable in the data frame:
sales$totalv1 <- sales$product1 + sales$product2 + sales$product3 
sales
# The same but using "with":
sales$totalv2 <- with(sales, product1+product2+product3)
sales

#' ***
#' Sometimes, we do not want to work with a whole data set but only with a subset. This can be easily ahcieved with the command ````subset(df, criterion)```, where *criterion* is a logical expression which evaluetes to TRUE for the rows which are to be selected. 
## ------------------------------------------------------------------------
# Subset: all years in which sales of product 3 were >=3
subset(sales, product3>=3)

#' 
