install.packages("DBI")
install.packages("RMySQL")
library(DBI)
library(RMySQL)

con <- dbConnect(RMySQL::MySQL(), 
                 dbname = "tweater", 
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                 port = 3306,
                 user = "student",
                 password = "datacamp")


class(con)

# lista de tabelas
dbListTables(con)

tables <- dbListTables(con)
str(tables)

users <- dbReadTable(con, "users")
head(users)

table_names <- dbListTables(con)
tables <- lapply(table_names, dbReadTable, conn = con)
tables
# Desconectar do banco
# dbDisconnect(con)

elisabeth <- dbGetQuery(con, "SELECT tweat_id from comments where user_id = 1")
elisabeth

latest <- dbGetQuery(con,"Select post from tweats where date > '2015-09-21'")
latest



specific <- dbGetQuery(con,"Select message from comments where tweat_id = 77 and user_id > 4")
specific

short <- dbGetQuery(con, "SELECT id, name from users where CHAR_LENGTH(name) < 5")
short


res <- dbSendQuery(con, "SELECT * FROM comments WHERE user_id > 4")
dbFetch(res, n = 2)
dbFetch(res, n = 2)
dbClearResult(res)

long_tweats <- dbGetQuery(con, "SELECT post, date from tweats where CHAR_LENGTH(post) > 40")
long_tweats

# DEsconecta da base de dados
dbDisconnect(con)


library(readr)
url_csv <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/swimming_pools.csv"
pools <- read_csv(url_csv)

url_delim <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/potatoes.txt"
potatoes <- read_tsv(url_delim)

pools
potatoes


# https 
url_csv <- "https://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/swimming_pools.csv"

pools1 <- read.csv(url_csv)
pools2 <- read_csv(url_csv)

str(pools1)
str(pools2)


library(readxl)
library(gdata)

url_xls <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/latitude.xls"

excel_gdata <- read.xls(url_xls)

download.file(url_xls, "local_latitude.xls")

excel_readxl <- read_excel("local_latitude.xls")


url_rdata <- "https://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/wine.RData"
download.file(url_rdata, "wine_local.RData")
load("wine_local.RData")
summary(wine)


install.packages("httr")
library(httr)

url <- "http://www.example.com/"
resp <- GET(url)

resp

raw_content <- content(resp, as = "raw")
raw_content

url <- "http://www.omdbapi.com/?apikey=ff21610b&t=Annie+Hall&y=&plot=short&r=json"
resp <- GET(url)

resp

content(resp, as = "text")
content(resp)
