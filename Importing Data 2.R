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

install.packages("jsonlite")
library(jsonlite)

#fromJSON() ir? converter em uma lista
wine_json <- '{"name":"Chateau Migraine", "year":1997, "alcohol_pct":12.4, "color":"red", "awarded":false}'
wine <- fromJSON(wine_json)

str(wine)

# fromJSON tbm pode acessar url
quandl_url <- "https://www.quandl.com/api/v3/datasets/WIKI/FB/data.json?auth_token=i83asDsiWUUyfoypkgMz"
quandl_data <- fromJSON(quandl_url)
str(quandl_data)

url_sw4 <- "http://www.omdbapi.com/?apikey=ff21610b&i=tt0076759&r=json"
url_sw3 <- "http://www.omdbapi.com/?apikey=ff21610b&i=tt0121766&r=json"

sw4 <- fromJSON(url_sw4)
sw3 <- fromJSON(url_sw3)

sw4$Title
sw3$Title

sw4$Year > sw3$Year

json1 <- '[1, 2, 3, 4, 5, 6]'
fromJSON(json1)

json2 <- '{"a": [1, 2, 3], "b": [4, 5, 6]}'
fromJSON(json2)



json1 <- '[[1, 2], [3, 4], [5, 6]]'
j <- fromJSON(json1)[1:2,]
matrix(j, ncol=2)

json2 <- '[{"a": 1, "b": 2}, {"a": 3, "b": 4}, {"a":5, "b":6}]'
fromJSON(json2)


url_csv <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/water.csv"
water <- read.csv(url_csv, stringsAsFactors = FALSE)
water_json <- toJSON(water)
water_json

# pretty ira deixar o json identado para melhor visualizacao, por default ele ? setado como false
pretty_json <- toJSON(mtcars, pretty= TRUE)
pretty_json

mini_json <- minify(pretty_json)
mini_json

# podemos usar o minify para convert uma string JSON identada para minificada
# e podemos usar o prettify para convert uma string JSON minificada em um identada

prettify(mini_json)

#o poacote haven ? meio facil de importa dados de softwares de staticas como SAS, STATA, e SPSS
# abaixo as fun?oes que s?o utilizadas pra cada tipo de software
# SAS: read_sas()
# STATA: read_dta() (or read_stata(), which are identical)
# SPSS: read_sav() or read_por(), depending on the file type.
install.packages("haven")
library(haven)

sales <- read_sas("DataSets/sales.sas7bdat")
str(sales)

#Ao importar arquivos .dta (stata) ir? perceber que existe colunas importada como labelled(pelo que eu entendi ? muito parecido com factor do R)
sugar <- read_dta("http://assets.datacamp.com/production/course_1478/datasets/trade.dta")
str(sugar)
# as_factor convert o labelled em um factor
as_factor(sugar$Date)
sugar$Date <- as.Date(as_factor(sugar$Date))
str(sugar)

traits <- read_sav("DataSets/person.sav")
summary(traits)
subset(traits, Extroversion > 40 & Agreeableness > 40)


work <- read_sav("http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/employee.sav")
summary(work$GENDER)
work$GENDER <- as_factor(work$GENDER)
summary(work$GENDER)

install.packages("foreing")
library(foreign)
florida <- read.dta("DataSets/florida.dta")
tail(florida)

path <- file.path("DataSets", "edequality.dta")

edu_equal_1 <- read.dta(path)
str(edu_equal_1)

edu_equal_2 <- read.dta(path, convert.factors = FALSE)
str(edu_equal_2)

edu_equal_3 <- read.dta(path, convert.underscore = TRUE)
str(edu_equal_3)

head(edu_equal_1)


demo <- read.spss("DataSets/international.sav", to.data.frame = TRUE)
boxplot(demo$gdp)
demo_1 <- read.spss("DataSets/international.sav", to.data.frame = TRUE)
head(demo_1)
str(demo_1)
demo_2 <- read.spss("DataSets/international.sav", to.data.frame = TRUE, use.value.labels = FALSE)
head(demo_2)
str(demo_2)