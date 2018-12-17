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
