# Functions and Arguments

weight <- sqrt(10) 

round(3.1459)
round(3.1459, digits = 2)
round(3.1459, digits = 0)


args(round)

round(digits = 2, x = 3.1418)

# Vectors and data types

weight_g <- c(50,60,65,82) # vectors
animals <- c("mouse", "rat", "dog")

class(animals) # how to find the types of animals and it's character
class(weight_g) # it's mumeric

# logical Vectors
logical_vector <- c(TRUE,TRUE,FALSE,FALSE)

# atomic vectors
num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

class(num_char)
class(num_logical)
class(char_logical)
class(tricky)

# atomic vectors is mixed vectors and we can considered those based on the hierarchy which is character > murical > logical vector

# SUBSETTING VECTORS

animals[2]
animals[2:3]
animals[c(2,3)]
animals[-c(2,3)] #subset data that you don't want

# Conditional subsetting

weight_g <- c(21,34,39,54,55)
weight_g[c(TRUE,FALSE,FALSE,TRUE,TRUE)]
weight_g > 50
weight_g[weight_g > 50 | weight_g >30]
weight_g[weight_g > 50 & weight_g <30]

# Missing Values

height <-  c(2,4,4,NA,6)
mean(height) #you will get an NA 
mean(height, na.rm = TRUE) #removed or filter NA

########
library(tidyverse)
library(ggplot2)


