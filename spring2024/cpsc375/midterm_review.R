# Common Data Types in R

# <- is the assignment operator

int <- 8
float <- 5.40 
arr <- c(5, 3, 30)
string <- "Hello World!"
booleanTrue <- TRUE
booleanFalse <- FALSE

# Arrays can have different datatypes in R
mixedArr <- c("Golf", 6.4, 97) # gets converted to char*

# Operators in R
a <- 54
b <- 7

# Basic Operations
addition <- a + b
subtraction <- a - b
multiplication <- a * b
division <- a / b
exponetial <-  b ^ a

# Logarithms, Exponential, Absolute, and Square Root

# Natural Log
logE <- log(3)
# Log Base 2
logOf2 <- log2(8)
# Log Base 10
logOf10 <- log10(1000)
# Exponential
exponent <- exp(9)
# Absolute Value
absolute <- abs(-69)
# Square Root
squareRoot <- sqrt(100)

# Vectorized Functions - Most Functions in R take a Vector as Input
sumArr <- sum(arr)

# Operator on a Vector
power2Vec <- arr ^ 2

# Logical Operators can be applied too!
result <- sumArr & arr

# This below code will Not Run Because mixedArr is of mixed types
# result2 <- sumArr & mixedArr

# Indexes start at '1' in R
arr[1:1] # Will print the first number in the array which is '5'

# Calculate the following of the Vector [2, 4 ,3]
classWork1 <- c(2, 4, 3)
# Mean
meanWk1 <- mean(classWork1)
# Magnitude
squareWk1 <- classWork1^2
sumWk1 <- sum(squareWk1)
mag <- sqrt(sumWk1) 
normalizedVec <- classWork1 / mag
magNormalizedVector <- sqrt(sum(normalizedVec^2))

# Mean of Numbers 1 - 100
mean100 <- mean(c(1:100))

# A List in R is a collection of Arbitrary Data Types - the right way to have an 
# array of mixed type
listArr <- list(TRUE,"Golf", 6.4, 97)

# List Elements can have names
listArr <- list(bool=TRUE,string="Golf", flt=6.4, num=97)

listArr['bool'] # Will print 'TRUE'

# Another way to access list elements with Names
listArr$num # Will print '97'

# There are also matricies, but more specifically dataframes are used in R

