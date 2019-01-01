#Explorando dados
bmi <- read.csv("DataSets/bmi_clean.csv")

# mostra o tipo de dado
class(bmi)

# mostra a dimensão do dataframe
dim(bmi)

# mostra o nomes das colunas
names(bmi)

#head mostra as primiras linhas, por default mostra 6
head(bmi)

# tail mostra as ultimas linhas, por default mostra 6
tail(bmi)

# mostra a estrutura do dataframe
str(bmi)

# Load dplyr
library(dplyr)

# metodo do pacote dplyr muito parecido com str
glimpse(bmi) 

# summary mostra o resumo dos dados
summary(bmi)


bmi
head(bmi)
head(bmi, 15)
tail(bmi)
tail(bmi, 10)

#Visualizando dados
# histograma, grafico que mostra a frequencia que os valores são apresentados
hist(bmi$Y2008)

# plot - mostra o grafico scatter plot que mostra a relação de duas variaveis
plot(bmi$Y1980, bmi$Y2008)

#pacote tidyr
install.packages("tidyr")
library(tidyr)


# o metodo gather é utilizado quando vc quer transforma o seu dados como se fosse chave e valor
# no exemplo a abaixo a variavel country permanece poque colocamos pra excluir ela
# e as outras colunas vira chave e valor
bmi_long <- gather(bmi, year, bmi_val, -Country)
head(bmi_long, 20)


# spread faz o contrario, atráves de uma chave ele transforma o registro em uma coluna e coloca com os seus valores
bmi_wide <- spread(bmi_long, year, bmi_val)
head(bmi_wide)

# unite junta duas colunas em uma, e adiciona um separador entre os valores
bmi_cc <- unite(bmi_long, Year_Val, year, bmi_val, sep = "-")
head(bmi_cc)

# separate, separa o valor da coluna em novas colunas
bmi_cc_clean <- separate(bmi_cc, col = Year_Val, into = c("year", "val"), sep = "-")
head(bmi_cc_clean)


library(dplyr)
census <- read.csv("DataSets/census-retail.csv")
head(census)

census2 <- gather(census, month, amount, -YEAR)
census_long <- arrange(census2, YEAR)
head(census_long)



head(census_long, 50)
census_long2 <- spread(census_long, month, amount)
head(census_long2, 20)

# Make this evaluate to "character"
class("TRUE")

# Make this evaluate to "numeric"
class(8484.00)

# Make this evaluate to "integer"
class(99L)

# Make this evaluate to "factor"
class(factor("factor"))

# Make this evaluate to "logical"
class(FALSE)

library(lubridate)

dmy("17 Sep 2015")
mdy_hm("July 15, 2012 12:56")

bith <- ymd_hms("1991 Feb 04 10:00:00")
bith
class(bith)


# manipulando strings

library(stringr)

str_trim(c("   Filip ", "Nick  ", " Jonathan"))

str_pad(c("23485W", "8823453Q", "994Z"), width = 9, side = 'left', pad = "0")

toupper("texto")
tolower("TEXTO")

str_detect(c("banana", "kiwi"), "a")
str_replace(c("banana", "kiwi"), "a", "o")




# Call is.na() on the full social_df to spot all NAs
is.na(social_df)

# Use the any() function to ask whether there are any NAs in the data
any(social_df$n_friends)

# View a summary() of the dataset
summary(social_df)

# Call table() on the status column
table(social_df$status)


# Replace all empty strings in status with NA
social_df$status[social_df$status == ""] <- NA

# Print social_df to the console
social_df

# Use complete.cases() to see which rows have no missing values
complete.cases(social_df)

# Use na.omit() to remove all rows with any missing values
na.omit(social_df)




library(readr)

weather <- read_rds("DataSets/weather.rds")

# Verify that weather is a data.frame
class(weather)

# Check the dimensions
dim(weather)

# View the column names
names(weather)


# View the structure of the data
str(weather)

# Load dplyr package
library(dplyr)

# Look at the structure using dplyr's glimpse()
glimpse(weather)

# View a summary of the data
summary(weather)

# View first 6 rows
head(weather)

# View first 15 rows
head(weather, 15)

# View the last 6 rows
tail(weather)

# View the last 10 rows
tail(weather,10)


# Load the tidyr package
library(tidyr)

# Gather the columns
weather2 <- gather(weather, day, value, X1:X31, na.rm = TRUE)

# View the head
head(weather2)

# First remove column of row names
without_x <- weather2[, -1]

# Spread the data
weather3 <- spread(without_x, measure, value)

# View the head
head(weather3)

# Load the stringr and lubridate packages
library(stringr)
library(lubridate)

# Remove X's from day column
weather3$day <- str_replace(weather3$day, "X", "")

# Unite the year, month, and day columns
weather4 <- unite(weather3, date, year, month, day, sep = "-")

# Convert date column to proper date format using lubridates's ymd()
weather4$date <- ymd(weather4$date) 

# Rearrange columns using dplyr's select()
weather5 <- select(weather4, date, Events, CloudCover:WindDirDegrees)

# View the head of weather5
head(weather5)


# View the structure of weather5
str(weather5)

# Examine the first 20 rows of weather5. Are most of the characters numeric?
head(weather5, 20)

# See what happens if we try to convert PrecipitationIn to numeric
as.numeric(weather5$PrecipitationIn)

# Replace "T" with "0" (T = trace)
weather5$PrecipitationIn <- str_replace(weather5$PrecipitationIn, "T", "0")

# Convert characters to numerics
weather6 <- mutate_at(weather5, vars(CloudCover:WindDirDegrees), funs(as.numeric))

# Look at result
str(weather6)

# Count missing values
sum(is.na(weather6))

# Find missing values
summary(weather6)

# Find indices of NAs in Max.Gust.SpeedMPH
ind <- which(is.na(weather6$Max.Gust.SpeedMPH))

# Look at the full rows for records missing Max.Gust.SpeedMPH
weather6[ind, ]

# Review distributions for all variables
summary(weather6)

# Find row with Max.Humidity of 1000
ind <- which(weather6$Max.Humidity == 1000)

# Look at the data for that day
weather6[ind, ]

# Change 1000 to 100
weather6$Max.Humidity[ind] <- 100

# Look at summary of Mean.VisibilityMiles
summary(weather6$Mean.VisibilityMiles)

# Get index of row with -1 value
ind <- which(weather6$Mean.VisibilityMiles == -1)

# Look at full row
weather6[ind, ]

# Set Mean.VisibilityMiles to the appropriate value
weather6$Mean.VisibilityMiles[ind] <- 10

# Review summary of full data once more
summary(weather6)

# Look at histogram for MeanDew.PointF
hist(weather6$MeanDew.PointF)

# Look at histogram for Min.TemperatureF
hist(weather6$Min.TemperatureF)

# Compare to histogram for Mean.TemperatureF
hist(weather6$Mean.TemperatureF)


# Replace empty cells in events column
weather6$events[weather6$events == ""] <- "None" 

# Print the first 6 rows of weather6
head(weather6)