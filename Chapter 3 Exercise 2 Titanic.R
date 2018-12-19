library(readr)
library(dplyr)
library(tidyr)
library(stringr)

my_df <- read.csv("titanic_original.csv")

glimpse(my_df)

#Checking for presence of empty rows in embarked
any(my_df$embarked == "")
any(str_locate(my_df$embarked, ""))

#str_replace_all(my_df$embarked, "", "S") creates "Error: Empty `pattern`` not supported"
#No idea how to fix this so I am going to work around it. 

# I think I fixed it but at this point I am not sure.  I need to find 
#a more certain way to check whether or not it worked. 

my_df$embarked[my_df$embarked ==""] = "S"
str_locate(my_df$embarked, "")
str_detect(my_df$embarked, "")

#figuring out the mean age of the ages recorded

mean_age <- mean(my_df$age, na.rm = TRUE)

#copied off of a stackoverflow page and adapted to this assignment

age_replace <- function(x) { replace(x, is.na(x), mean_age) }

#calling the function on the age column

age_replace(my_df$age)

# replacing the empty values in the boat column with NA. 
#Stolen from a Datacamp exercise.  I don't understand why I need to 
#have the dataframe and column and then brackets and the data frame and 
#column again.  I am clearly missing something fundamental here 

my_df$boat[my_df$boat == ""] <- NA

#Adding a new column and attaching a binary logical that is then converted
#into 1 or 0 depending on if a value in cabin exists... not sure how to do 
#that yet. 

#Following the advice of Blaine Bateman on the Springboard forum I used
#mutate in combination with case_when and now I have a new column with 
#1 or 0 if they have a cabin or do not have a cabin number respectively

my_df2<- my_df %>% 
  mutate(has_cabin_number = case_when(
             cabin != "" ~ 1,
            cabin == "" ~ 0)
)

#Loading the last dataframe into a csv to wrap up assignment 
write.csv(my_df2, "titanic_clean.csv")