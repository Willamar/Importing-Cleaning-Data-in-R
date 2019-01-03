sales <- read.csv("DataSets/sales.csv", stringsAsFactors = FALSE)

# View dimensions of sales
dim(sales)

# Inspect first 6 rows of sales
head(sales)

# View column names of sales
names(sales)


# Look at structure of sales
str(sales)

# View a summary of sales
summary(sales)

# Load dplyr
library(dplyr)

# Get a glimpse of sales
glimpse(sales)



# Remove the first column of sales: sales2
sales2 <- sales[,-1]

# Define a vector of column indices: keep
keep <- 5:(ncol(sales2) - 15)

# Subset sales2 using keep: sales3
sales3 <- sales2[,keep]


# Load tidyr
library(tidyr)

# Split event_date_time: sales4
sales4 <- separate(sales3, event_date_time,
                   c("event_dt", "event_time"), sep = " ")

# Split sales_ord_create_dttm: sales5

sales5 <- separate(sales4, sales_ord_create_dttm,
                   c("ord_create_dt", "ord_create_time"), sep = " ")


# Define an issues vector
issues <- c( 2516, 3863, 4082, 4183)

# Print values of sales_ord_create_dttm at these indices
sales3[issues, ]$sales_ord_create_dttm

# Print a well-behaved value of sales_ord_create_dttm
sales3[2517, ]$sales_ord_create_dttm



# Load stringr
library(stringr)

# Find columns of sales5 containing "dt": date_cols
date_cols <- str_detect(names(sales5), "dt")

# Load lubridate
install.packages("lubridate")
require(lubridate)

# Coerce date columns into Date objects
sales5[, date_cols] <- lapply(sales5[, date_cols], ymd)

# Find date columns (don't change)
date_cols <- str_detect(names(sales5), "dt")

# Create logical vectors indicating missing values (don't change)
missing <- lapply(sales5[, date_cols], is.na)

# Create a numerical vector that counts missing values: num_missing
num_missing <- sapply(missing, sum)

# Print num_missing
num_missing


# Combine the venue_city and venue_state columns
sales6 <- unite(sales5, venue_city_state, 
                venue_city, venue_state, sep = ", ")

# View the head of sales6
head(sales6)


#Part 2
# Load readxl
library(readxl)

# Import mbta.xlsx and skip first row: mbta
mbta <- read_excel("DataSets/mbta.xlsx", skip=1)

# View the structure of mbta
str(mbta)

# View the first 6 rows of mbta
head(mbta)

# View a summary of mbta
summary(mbta)

# Remove rows 1, 7, and 11 of mbta: mbta2
mbta2 <- mbta[-c(1,7,11),]

# Remove the first column of mbta2: mbta3
mbta3 <- mbta2[,-1]

# Load tidyr
library(tidyr)
install.packages("stringi")

# Gather columns of mbta3: mbta4
mbta4 <- gather(mbta3, month, thou_riders, -mode)

# View the head of mbta4
head(mbta4)

# Coerce thou_riders to numeric
mbta4$thou_riders <- as.numeric(mbta4$thou_riders)

# Spread the contents of mbta4: mbta5
mbta5 <- spread(mbta4, mode, thou_riders)

# View the head of mbta5
head(mbta5)


# Split month column into month and year: mbta6
mbta6 <- separate(mbta5, month, c("year", "month"), sep="-")

# View the head of mbta6
head(mbta6)

# View a summary of mbta6
summary(mbta6)

# Generate a histogram of Boat column
hist(mbta6$Boat)

# Find the row number of the incorrect value: i
i <- which(mbta6$Boat == 40)

# Replace the incorrect value with 4
mbta6[i,]$Boat <- 4

# Generate a histogram of Boat column
hist(mbta6$Boat)

# Look at Boat and Trackless Trolley ridership over time (don't change)
ggplot(mbta_boat, aes(x = month, y = thou_riders, col = mode)) +  geom_point() + 
  scale_x_discrete(name = "Month", breaks = c(200701, 200801, 200901, 201001, 201101)) + 
  scale_y_continuous(name = "Avg Weekday Ridership (thousands)")

# Look at all T ridership over time (don't change)
ggplot(mbta_all, aes(x = month, y = thou_riders, col = mode)) + geom_point() + 
  scale_x_discrete(name = "Month", breaks = c(200701, 200801, 200901, 201001, 201101)) +  
  scale_y_continuous(name = "Avg Weekday Ridership (thousands)")



#PARTE 3
# Load data.table
library(data.table)

# Import food.csv as a data frame: df_food
food <- fread("DataSets/food.csv", data.table = FALSE)


# View summary of food
summary(food)

# View head of food
head(food)

# View structure of food
str(food)

# Load dplyr
library(dplyr)

# View a glimpse of food
glimpse(food)

# View column names of food
names(food)

# Define vector of duplicate cols (don't change)
duplicates <- c(4, 6, 11, 13, 15, 17, 18, 20, 22, 
                24, 25, 28, 32, 34, 36, 38, 40, 
                44, 46, 48, 51, 54, 65, 158)

# Remove duplicates from food: food2
food2 <- food[, -duplicates]

# Define useless vector (don't change)
useless <- c(1, 2, 3, 32:41)

# Remove useless columns from food2: food3
food3 <- food2[, -useless]

library(stringr)
# Create vector of column indices: nutrition
nutrition <- str_detect(names(food3), "100g")

# View a summary of nutrition columns
summary(food3[, nutrition])


# Find indices of sugar NA values: missing
missing <- is.na(food3$sugars_100g)

# Replace NA values with 0
food3[missing,]$sugars_100g <- 0

# Create first histogram
hist(food3$sugars_100g, breaks = 100)

# Create food4
food4 <- food3[food3$sugars_100g > 0, ]

# Create second histogram
hist(food4$sugars_100g, breaks = 100)