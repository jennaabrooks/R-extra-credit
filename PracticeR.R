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
  filter (dest == 'IAH' |dest == 'HOU' )
# Were operated by United, American, or Delta
flights |> 
  distinct(carrier)
flights |> 
  filter(carrier == 'UA'  | carrier == "AA" | carrier == "DL")
flights |> 
  filter(carrier %in% c('UA', 'AA', 'DL'))
# Departed in summer (July, August, and September)
flights |> 
  filter (month %in% c('7', '8', '9'))

# Arrived more than two hours late but didn’t leave late
flights |>
  filter (arr_time >= 120 & dep_delay <= 0)

#Sort flights to find the flights with the longest departure delays. 
flights |> 
  arrange (desc(dep_delay))
#Find the flights that left earliest in the morning.
flights |> 
  arrange (dep_time)

#Sort flights to find the fastest flights. (Hint: Try including a math calculation inside of your function.)
flights |> 
  mutate(speed = distance / air_time) |>  # Add a new column for speed
  arrange(desc(speed))

#Was there a flight on every day of 2013?

# Get distinct combinations of year, month, and day
unique_days <- flights |> 
  distinct(year, month, day)

# Check if there was a flight on every day of 2013
total_days_2013 <- 365  # 2013 was not a leap year

if (nrow(unique_days) == total_days_2013) {
  print("Yes, there was a flight on every day of 2013.")
} else {
  print("No, there wasn't a flight on every day of 2013.")
}

#Columns 
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60
  ) |> 
  select(gain , dep_delay, arr_delay, )

#add column to the left of df so we can see what's happening. 
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .before = 1
  )
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours,
    .keep = "used"
  )

flights |> 
  select(year, month, day)

#select columns between year and day 
flights |> 
  select(year:day)
#all columns except year and day 
flights |> 
  select(!year:day)

#rename variables 
flights |> 
  select(tail_num = tailnum)

flights |> 
  rename(tail_num = tailnum)

#janitor::clean_names() useful for cleaning a lot of names 

#move variables to the front 
flights |> 
  relocate(time_hour, air_time)

#Compare dep_time, sched_dep_time, and dep_delay. How would you expect those three numbers to be related?
flights |> 
  relocate(dep_time, sched_dep_time, dep_delay)

#Pipe 
flights |> 
  filter(dest == "IAH") |> 
  mutate(speed = distance / air_time * 60) |> 
  select(year:day, dep_time, carrier, flight, speed) |> 
  arrange(desc(speed))
