# Install the tidyverse package if you haven't installed it yet
#install.packages("tidyverse")

# Load the necessary libraries
library(tidyverse)
library(nycflights13)

flights <- nycflights13::flights
flights |>
  filter(dest == "IAH") |> 
  group_by(year, month, day) |> 
  summarize(
    arr_delay = mean(arr_delay, na.rm = TRUE)
  )
#"then' |> 

#Rows 
# It doesn’t modify the existing flights dataset because dplyr functions never modify their inputs. 
#To save the result, you need to use the assignment operator, <-:
jan1 <- flights |> 
  filter(month == 1 & day == 1)
jan1
jan2 <- flights |> 
  filter(month == 1 & day == 2)
jan2


#arrange() changes the order of the rows based on the value of the columns
flights
flights |> 
  arrange(year, month, day, dep_time)

flights |> 
  arrange(desc(dep_delay))

#distinct() finds all the unique rows in a dataset, so technically, it primarily operates on the rows.
# Remove duplicate rows, if any
flights |> 
  distinct()
flights |> 
  distinct(origin, dest)

flights |> 
  distinct(origin, dest, .keep_all = TRUE)

flights |>
  count(origin, dest, sort = TRUE)
#3.2.5 Exercises
# In a single pipeline for each condition, find all flights that meet the condition:
#   
#   Had an arrival delay of two or more hours
flights |> 
  filter(arr_delay >= 120)

# Flew to Houston (IAH or HOU)
flights |> 
  filter (dest == 'IAH' | )
# Were operated by United, American, or Delta
# Departed in summer (July, August, and September)
# Arrived more than two hours late but didn’t leave late
# Were delayed by at least an hour, but made up over 30 minutes in flight
