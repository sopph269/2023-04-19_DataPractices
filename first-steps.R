library(tydivers)
library(ggplot2)


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
height[!is.na(height)]

########
library(tidyverse)
library(ggplot2)

download.file(
  url = "https://nbisweden.github.io/module-r-intro-dm-practices/data/Hawks.csv",
  destfile = "data_raw/Hawks.csv"
)

hawks <- read.csv("data_raw/Hawks.csv")

## inspect dataset ##
dim(hawks)

#size of row and column
nrow(hawks) #return the number of rows
ncol(hawks) #return the number of columns

#content
head(hawks)
tail(hawks)

#names
names(hawks) #returns the column names (synonym of colnames() for data.frame objects)
rownames(hawks) # return the row names

#summary
str(hawks) # structure of the object and information about the class, length and content of each column
summary(hawks) # statistics each column

# subsetting data

hawks[3,10]
hawks[10]
hawks[3:4, 10:16]

hawks$Wing


### Manipulating analysing and exporting data with tidyverse

# seleecting data with tidyverse

select(hawks, Species, Sex, Weight) #selecting only species, sex, and weight in dataset

select(hawks, -Species, -Sex, -Weight) #selecting anything not species, sex and weight

drop_na(hawks, Species, Sex, Weight) #same above

# filtering data with tidyverse

filter(hawks, Sex=="F")

# combine filtre and select

hawks_females <- filter(hawks, Sex == "F")
hawks_female_sml <- select(hawks_females, Species, Sex, Weight)

# Pipe
filter(hawks, Sex =="F") %>% 
  select(Species, Sex, Weight)

# 3.1
filter(hawks, Sex == "M" & Weight > 500) %>% 
  select(Species, Weight)

hawks %>%
  filter(Sex == "M" & Weight > 500) %>%
  select(Species, Weight)

# modifying data with mutate()
hawks %>% 
  mutate(Weight_kg = Weight/ 1000)

hawks %>% 
  mutate(Weight_kg = Weight / 1000, Weight_lb = Weight_kg / 2.2)

# 3.2
hawks %>% 
  mutate(Tarsus_cm = Tarsus / 10) %>% 
  filter(Tarsus_cm < 6) %>% 
  drop_na(Tarsus_cm) %>% 
  select(Species, Tarsus_cm)

# creating a convert kg_to_lb() function

kg_to_lb <- function(x) {
  lb <- x * 2.462262
  return(lb)
} 

kg_to_lb(34)
kg_to_lb(c(23,45,50))

# 3.3
hawks %>% 
  mutate(Wight_lb = kg_to_lb(Weight))

# 3.4
hawks %>% 
  filter(Weight > 500) %>% 
  count(Year) #counting year

hawks %>% 
  group_by(Sex) %>% 
  summarize(mean = mean(Weight, na.rm = TRUE))

hawks %>% 
  group_by(Species, Sex) %>% 
  summarize(mean = mean(Weight, na.rm = TRUE), min = min(Weight, na.rm = TRUE))

large_bird_counts <- hawks %>% 
  filter(Weight > 500) %>% 
  count(Species, Sex)

write_csv(large_bird_counts, "data_processed/large_bird_counts.csv")


#### Plot Dataset with ggplot2 ###
# ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) +  <GEOM_FUNCTION>() + ...

ggplot(hawks, mapping = aes(x = Weight, y = Wing)) + 
  geom_point(alpha=0.5, color = "blue")


ggplot(hawks, mapping = aes(x = Weight, y = Wing)) + 
  geom_point(alpha=0.5, aes(color = Species))

# 4.2
ggplot(hawks, mapping = aes(x = Species, y = Wing)) + 
  geom_jitter(alpha = 0.5, color = "blue") +
  geom_boxplot()
             

ggplot(hawks, mapping = aes(x = Weight, y = Wing)) + 
  geom_point() +
  scale_x_log10() +
  labs(title = "Weight vs. Wing Lenght", y = "Wing Lenght")

# facet wrap into subset plot
ggplot(hawks, mapping = aes(x = Weight, y = Wing)) + 
  geom_point(lpha=0.5, aes(color = Species)) +
  scale_x_log10() +
  labs(title = "Weight vs. Wing Lenght", 
       y = "Wing Lenght") +
  facet_wrap(vars(Species)) +
  theme_bw()




