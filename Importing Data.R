# Importando arquivo csv
pools <- read.csv("DataSets/swimming_pools.csv")
str(pools)

# Por padrão o read.csv já irá importar as strings como factor.
# para que isso não ocorra devemos definir o parametro StringsAsFactors como FALSE
pools <- read.csv("DataSets/swimming_pools.csv", stringsAsFactors = FALSE)
str(pools)

# Podemos usar a função read.delim() para ler arquivos
# Por padrão ele irá dividir os campos pelo delimitador \t (tab)
# e a primeira linha ele defini como o cabeçalho
hotdogs <- read.delim("DataSets/hotdogs.txt")
head(hotdogs)
# header = FALSE defini que a primeira linha não é o cabeçalho
hotdogs <- read.delim("DataSets/hotdogs.txt", header = FALSE)
head(hotdogs)
summary(hotdogs)

path <- file.path("DataSets", "hotdogs.txt")

#por padrão read.table header estará como falso e o separador(delimitador) em branco ""
hotdogs <- read.table(path, 
                      sep = "\t", 
                      col.names = c("type", "calories", "sodium"))
# col.names difini o nome das colunas
head(hotdogs)
# tbm podemos utilizado col.names na função read.delim
hotdogs <- read.delim(path, header = FALSE, col.names = c("type", "calories", "sodium"))

#which.min pega o indice de menor valor
which.min(hotdogs$calories)
lily <- hotdogs[which.min(hotdogs$calories), ]
lily
#which.max pega o indice de maior valor
tom <- hotdogs[which.max(hotdogs$sodium), ]
tom

#podemos definir quais são os tipos de dados em nossa coluna
#isso é util quando vc tem algumas colunas q não são factors
hotdogs2 <- read.delim(path, header = FALSE, 
                       col.names = c("type", "calories", "sodium"),
                       colClasses = c("factor", "numeric", "numeric"))
head(hotdogs2)
#Se difinirmos algum tipo como "NULL" ele não será carregado
hotdogs2 <- read.delim(path, header = FALSE, 
                       col.names = c("type", "calories", "sodium"),
                       colClasses = c("factor", "NULL", "numeric"))
head(hotdogs2)

#read.csv e read.delim irá chamar o read.table

# Irá listar todos os arquivos/pasta que existe no diretorio
dir()
dir("DataSets/")

install.packages("readr")
library(readr)
potatoes <- read_csv("DataSets/potatoes.csv")


properties <- c("area", "temp", "size", "storage", "method",
                "texture", "flavor", "moistness")
# tsv - separador é o tab
potatoes <- read_tsv("DataSets/potatoes.txt", col_names = properties)
head(potatoes)

# read_delim é a função principal do pacote readr(assim como read.table é a função principal de utils)
# devemos passar dois argumentos, arquivos, e o delimitador
potatoes <- read_delim("DataSets/potatoes.txt", col_names = properties, delim = "\t")
head(potatoes)

# o argumento skip determina a quantidade de linha que vai ser ignorada no começo do arquivo
# nmax - quantidade de linha que irá importar do arquivo
potatoes_fragment <- read_tsv("DataSets/potatoes.txt", skip = 6, n_max = 5, col_names = properties)


# podemos definir os tipos das colunas com o argumento col_types 
# Se passar como NULL ele irá ignorar a coluna
# c - character, d double, i integer, l logical, _ skips
potatoes_char <- read_tsv("DataSets/potatoes.txt", col_types = "cccccccc", col_names = properties)
str(potatoes_char)

# Outra maneira de difinir os tipos das colunas é usando o collectors
# as funções collector devem ser passadas para uma lista e como argumento de col_types
fac <- col_factor(levels = c("Beef", "Meat", "Poultry"))
int <- col_integer()
hotdogs_factor <- read_tsv("DataSets/hotdogs.txt",
                           col_names = c("type", "calories", "sodium"),
                           col_types = list(fac, int, int))
summary(hotdogs_factor)


#fread é um pacote facil e rapido de usar, é muito parecido com read.table()
# muitas vezes só precisamos especificar o caminho do arquivo para que os nossos dados possam ser importados com sucesso
install.packages("data.table")
library(data.table)

potatoes <- fread("DataSets/potatoes.csv")
potatoes


#fread - drop e select
#drop - seleciona as colunas que não quero importar do arquivo
#select - seleciona as colunas que quero importar do arquivo

potatoes <- fread("DataSets/potatoes.csv", select = c(6,8))
potatoes <- fread("DataSets/potatoes.csv", drop = c(1:5,7))
potatoes <- fread("DataSets/potatoes.csv", select = c('texture','moistness'))
potatoes <- fread("DataSets/potatoes.csv", drop = c('area','temp','size','storage','method','flavor'))
plot(potatoes$texture, potatoes$moistness)

potatoes_fread <- fread("DataSets/potatoes.csv")
potatoes_readr <- read_csv("DataSets/potatoes.csv")

class(potatoes_fread)
class(potatoes_readr)


# Lendo arquivos xlsx com a pacote readxl
install.packages("readxl")
library(readxl)


excel_sheets("DataSets/urbanpop.xlsx")

pop_1 <- read_excel("DataSets/urbanpop.xlsx", sheet = 1)
pop_2 <- read_excel("DataSets/urbanpop.xlsx", sheet = 2)
pop_3 <- read_excel("DataSets/urbanpop.xlsx", sheet = "1975-2011")
pop_list <- list(pop_1, pop_2, pop_3)
str(pop_list)

pop_list <- lapply(excel_sheets("DataSets/urbanpop.xlsx"), read_excel, path="DataSets/urbanpop.xlsx")
str(pop_list)

# Por default o read_excel irá importar o arquivo com o header
pop_a <- read_excel("DataSets/urbanpop.xlsx", sheet = 1, col_names = FALSE)
cols <- c("country", paste0("year_", 1960:1966))
pop_b <- read_excel("DataSets/urbanpop.xlsx", sheet = 1, col_names = cols)

summary(pop_a)
summary(pop_b)

# Argumento skip irá pular as linhas
urbanpop_skip <- read_excel("DataSets/urbanpop.xlsx", sheet = 2, skip = 21, col_names = FALSE)
urbanpop <- read_excel("DataSets/urbanpop.xlsx", sheet = 2, col_names = FALSE)

dim(urbanpop_skip)
dim(urbanpop)


install.packages("gdata")
library(gdata)

urban_pop <- read.xls("DataSets/urbanpop.xls", sheet="1967-1974")
head(urban_pop, 11)

columns <- c("country", paste0("year_", 1967:1974))

urban_pop <- read.xls("DataSets/urbanpop.xls", sheet = 2,
                      skip = 50, header = FALSE, stringsAsFactors = FALSE,
                      col.names = columns)
head(urban_pop, 10)

path <- "C:/Projetos/Importing-Cleaning-Data-in-R/DataSets/urbanpop.xls"
urban_sheet1 <- read.xls(path, sheet = 1, stringsAsFactors = FALSE)
urban_sheet2 <- read.xls(path, sheet = 2, stringsAsFactors = FALSE)
urban_sheet3 <- read.xls(path, sheet = 3, stringsAsFactors = FALSE)
urban <- cbind(urban_sheet1, urban_sheet2[-1], urban_sheet3[-1])
# na.omit irá retirar todas as linhas com valores NA
urban_clean <- na.omit(urban)
summary(urban)
summary(urban_clean)




install.packages("XLConnect")
library(XLConnect)
my_book <- loadWorkbook("DataSets/urbanpop.xlsx")
class(my_book)

my_book <- loadWorkbook("DataSets/urbanpop.xlsx")
getSheets(my_book)
readWorksheet(my_book, sheet = 2)

# Build connection to urbanpop.xlsx
my_book <- loadWorkbook("DataSets/urbanpop.xlsx")

# Import columns 3, 4, and 5 from second sheet in my_book: urbanpop_sel
urbanpop_sel <- readWorksheet(my_book, sheet = 2, startCol = 3, endCol = 5)

# Import first column from second sheet in my_book: countries
countries <- readWorksheet(my_book, sheet = 2, startCol = 1, endCol = 1)

# cbind() urbanpop_sel and countries together: selection
selection <- cbind( countries, urbanpop_sel)


# Build connection to urbanpop.xlsx
my_book <- loadWorkbook("urbanpop.xlsx")

# Add a worksheet to my_book, named "data_summary"
createSheet(my_book,"data_summary")

# Use getSheets() on my_book
getSheets(my_book)



# XLConnect is already available

# Build connection to urbanpop.xlsx
my_book <- loadWorkbook("urbanpop.xlsx")

# Add a worksheet to my_book, named "data_summary"
createSheet(my_book, "data_summary")

# Create data frame: summ
sheets <- getSheets(my_book)[1:3]
dims <- sapply(sheets, function(x) dim(readWorksheet(my_book, sheet = x)), USE.NAMES = FALSE)
summ <- data.frame(sheets = sheets,
                   nrows = dims[1, ],
                   ncols = dims[2, ])

# Add data in summ to "data_summary" sheet
writeWorksheet(my_book, summ, "data_summary")

# Save workbook as summary.xlsx
saveWorkbook(my_book,"summary.xlsx")


# my_book is available

# Rename "data_summary" sheet to "summary"
renameSheet(my_book, "data_summary", "summary")

# Print out sheets of my_book
getSheets(my_book)

# Save workbook to "renamed.xlsx"
saveWorkbook(my_book, "renamed.xlsx")


# Load the XLConnect package
library(XLConnect)

# Build connection to renamed.xlsx: my_book
my_book <- loadWorkbook("renamed.xlsx")

# Remove the fourth sheet
removeSheet(my_book, sheet = 4)

# Save workbook to "clean.xlsx"
saveWorkbook(my_book, "clean.xlsx")

