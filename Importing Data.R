# Importando arquivo csv
pools <- read.csv("DataSets/swimming_pools.csv")
str(pools)

# Por padr�o o read.csv j� ir� importar as strings como factor.
# para que isso n�o ocorra devemos definir o parametro StringsAsFactors como FALSE
pools <- read.csv("DataSets/swimming_pools.csv", stringsAsFactors = FALSE)
str(pools)

# Para ler arquivos txts usamos a fun��o read.delim()
# Por padr�o ele ir� dividir os campos pelo delimitador \t (tab)
# e a primeira linha ele defini como o cabe�alho
hotdogs <- read.delim("DataSets/hotdogs.txt")
head(hotdogs)
# header = FALSE defini que a primeira linha n�o � o cabe�alho
hotdogs <- read.delim("DataSets/hotdogs.txt", header = FALSE)
head(hotdogs)
summary(hotdogs)

path <- file.path("DataSets", "hotdogs.txt")

#por padr�o read.table header estar� como falso e o separador(delimitador) em branco ""
hotdogs <- read.table(path, 
                      sep = "\t", 
                      col.names = c("type", "calories", "sodium"))
# col.names difini o nome das colunas
head(hotdogs)
# tbm podemos utilizado col.names na fun��o read.delim
hotdogs <- read.delim(path, header = FALSE, col.names = c("type", "calories", "sodium"))

#which.min pega o indice de menor valor
which.min(hotdogs$calories)
lily <- hotdogs[which.min(hotdogs$calories), ]
lily
#which.max pega o indice de maior valor
tom <- hotdogs[which.max(hotdogs$sodium), ]
tom

#podemos definir quais s�o os tipos de dados em nossa coluna
#isso � util quando vc tem algumas colunas q n�o s�o factors
hotdogs2 <- read.delim(path, header = FALSE, 
                       col.names = c("type", "calories", "sodium"),
                       colClasses = c("factor", "numeric", "numeric"))
head(hotdogs2)
#Se difinirmos algum tipo como "NULL" ele n�o ser� carregado
hotdogs2 <- read.delim(path, header = FALSE, 
                       col.names = c("type", "calories", "sodium"),
                       colClasses = c("factor", "NULL", "numeric"))
head(hotdogs2)

#read.csv e read.delim ir� chamar o read.table