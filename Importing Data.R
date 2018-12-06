# Importando arquivo csv
pools <- read.csv("DataSets/swimming_pools.csv")
str(pools)

# Por padrão o read.csv já irá importar as strings como factor.
# para que isso não ocorra devemos definir o parametro StringsAsFactors como FALSE
pools <- read.csv("DataSets/swimming_pools.csv", stringsAsFactors = FALSE)
str(pools)

# Para ler arquivos txts usamos a função read.delim()
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
