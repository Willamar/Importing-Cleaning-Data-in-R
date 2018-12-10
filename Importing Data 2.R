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
