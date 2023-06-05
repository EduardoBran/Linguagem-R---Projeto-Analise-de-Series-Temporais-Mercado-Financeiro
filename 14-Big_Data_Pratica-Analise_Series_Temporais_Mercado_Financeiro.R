# Big Data na Prática - Análise de Séries Temporais no Mercado Financeiro 


# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/7.Projeto-BigDataNaPratica-Analise-de-Series-Temporais-no-Mercado-Financeiro")
getwd()



# Instalar e carregar os pacotes

install.packages("quantmod")
install.packages("xts")
install.packages("moments")

# quantmod: amplamente utilizado para análise quantitativa de dados financeiros no ambiente R. Ele oferece recursos para coletar dados
#           financeiros de várias fontes, como Yahoo Finance e Google Finance.
# xts:      O "xts" é útil para armazenar, manipular e analisar dados financeiros com carimbos de tempo, facilitando a indexação e a 
#           agregação de dados por datas. Ele também fornece funções para lidar com fusos horários, dados faltantes e realizar operações 
#           comuns em séries temporais, como subconjunto, agregação e transformação.
# moments:  O pacote "moments" oferece funções para calcular momentos estatísticos e medidas de resumo em R.

library(quantmod)   
library(xts)
library(moments)

library(dplyr)


# - Uma série temporal é uma sequência de observações coletadas em intervalos de tempo regular, como horas, dias, semanas, meses ou anos.

# - A análise de séries temporais tem como objetivo identificar padrões, tendências e estruturas subjacentes nos dados ao longo do tempo,
#   bem como fazer previsões sobre o seu comportamento futuro. Ela é amplamente utilizada em diversos campos, incluindo economia,
#   finanças, meteorologia, ciências sociais, engenharia, entre outros.

# - A análise de séries temporais no mercado financeiro é uma aplicação bastante relevante e útil. Ela permite estudar e prever o
#   comportamento de indicadores financeiros ao longo do tempo, como preços de ações, índices de mercado, taxas de juros, entre outros.



# Seleção do período de análise (definindo data para início e fim para buscar cotações de ações neste período)

start_date <- as.Date("2018-01-21")
end_date <- as.Date("2018-06-21")



# Download dos dados do périodo

# - Através da função getSymbols() do pacote quantmod informamos a empresa que iremos buscar as ações ("PETR4.SA" - Petrobras).
#   Tem que saber o código da empresa no Mercado de Ações. Cada empresa listada na bolsa de valores tem um código.
# - Informo a fonte ("yahoo", pode ser google), informo datas de início e fim

getSymbols("PETR4.SA", src = "yahoo", from = start_date, to = end_date, auto.assign = T)

class(PETR4.SA)
View(PETR4.SA)



# - O índice é a data. Isso que caracteria uma série temporal.



# Analisando/exbindo os dados de fechamento (Coluna "PETR4.SA.Close")

PETR4.SA.Close <- PETR4.SA[, "PETR4.SA.Close"]    # filtrando apenas coluna .Close . Não dá para fazer com dplyr por causa da classe
View(PETR4.SA.Close)



# Plotando o gráfico da Petrobras (gráfico de candlestick ou gráfico de velas da Petrobras)

candleChart(PETR4.SA)
candleChart(PETR4.SA.Close)



# Plotando o gráfico de fechamento

plot(PETR4.SA.Close, main = "Fechamento Diário Ações Petrobrás",
     col = 'red', xlab = 'Data', ylab = 'Preço',
     major.ticks = 'months', minor.ticks = FALSE)                         # demarcações de datas



# Adicionando as bandas de bollinger ao gráfico.

# - As Bandas de Bollinger são um indicador técnico utilizado na análise de séries temporais, especialmente no mercado financeiro.
# - Elas consistem em três linhas traçadas em um gráfico de preços: uma linha central e duas bandas, uma superior e uma inferior,
#   que são calculadas a partir do desvio padrão dos preços.

# - Iremos adicionar bandas de bollinger com média de 20 períodos e 2 desvios padrão
# - Mercados mais voláteis possuem as bandas mais distantes da média, mercados menos voláteis possuas bandas mais próximas a média.

# - No caso específico do código fornecido, estamos usando uma média móvel de 20 períodos e 2 desvios padrão.
# - Esses valores são comumente utilizados como parâmetros padrão para as Bandas de Bollinger, apesar que pode variar de acordo com o projeto
# - As Bandas de Bollinger são amplamente utilizadas na análise técnica para identificar condições de sobrecompra e sobrevenda, bem como
#   para detectar possíveis reversões de tendência.

addBBands(n = 20, sd = 2)



# Adicionando o indicador ADX, média 11 do tipo exponencial

# - Adiciona o indicador ADX (Average Directional Index) ao gráfico existente. É um indicador técnico utilizado na análise de séries temporais.
# - Os parâmetros utilizados são "n" e "maType". O parâmetro "n" representa o número de períodos para calcular a média do indicador ADX,
#   e no código fornecido está definido como 11. O parâmetro "maType" especifica o tipo de média a ser usada no cálculo do ADX, e no caso
#   do código fornecido, está definido como "EMA" (Exponential Moving Average), ou seja, média móvel exponencial.
# - O valor da média de 11 períodos é uma escolha arbitrária e pode ser ajustado de acordo com as preferências do analista ou as
#   características do ativo ou mercado sendo analisado. Geralmente, o ADX é calculado usando médias móveis de 14 períodos,

addADX(n = 11, maType = "EMA")



# Calculando logs diários

# - A função log() é aplicada aos preços de fechamento da ação da Petrobras, transformando-os em seus respectivos logaritmos naturais.
# - Em seguida, a função diff() é utilizada para calcular a diferença entre os logaritmos diários consecutivos, especificando o argumento
#   lag = 1. Essa diferença representa a variação logarítmica diária do preço de fechamento da ação.
# - O cálculo dos logs diários é comumente utilizado em análises de séries temporais financeiras, pois permite uma melhor visualização e
#   interpretação das variações percentuais diárias dos preços. Ao utilizar os logaritmos, as variações percentuais são transformadas em
#   variações lineares, facilitando a análise e a modelagem dessas variações.
# - Os logs diários são úteis para identificar padrões, tendências e volatilidade dos preços de um ativo financeiro ao longo do tempo.
# - Esta aplicação foi feita para melhor visualização dos dados no gráfico abaixo

# - A função log() é comumente usada para transformar valores que têm uma distribuição assimétrica em uma escala logarítmica. Essa
#   transformação pode ajudar a reduzir a variação entre os valores extremos e destacar as diferenças entre os valores menores. Isso é
#   particularmente útil quando os dados possuem uma ampla faixa de valores.
# - Ao aplicar a função diff() após a transformação logarítmica, estamos calculando as diferenças entre os valores consecutivos dos
#   logaritmos. Isso pode ajudar a identificar as mudanças relativas entre os valores ao longo do tempo ou sequência.
# - E ao plotar os dados transformados e suas diferenças no gráfico mais abaixo, podemos obter uma representação visual mais clara das
#   tendências, padrões ou mudanças nos dados originais. Essa abordagem pode facilitar a interpretação e análise dos dados,
#   especialmente em casos em que os valores originais têm uma variação ampla ou são assimetricamente distribuídos.

PETR4.SA.logs_diarios <- 
  diff(log(PETR4.SA.Close), lag = 1)

View(PETR4.SA.logs_diarios)


# Buscando / removendo valores NA

anyNA(PETR4.SA.logs_diarios) # retorna valor booleano
which(is.na(PETR4.SA.logs_diarios)) # retorna o índice onde está o valor NA

PETR4.SA.logs_diarios <- PETR4.SA.logs_diarios[-1] # remove primeira linha



# Plota a taxa de retorno

# - Foi feita a alteração acima onde aplicamos cálculo de logaritmo nos valores da coluna "PETR4.SA.Close" do objeto PETR4.SA.Close
#   e assim conseguimos alterar a escala do nosso gráfico para podermos visualizar melhor o gráfico de fechamento das ações
# - A utilização dos logaritmos dos retornos é uma prática comum em análise financeira, pois permite uma melhor visualização das
#   variações percentuais ao longo do tempo, especialmente quando essas variações são muito grandes. Dessa forma, o gráfico oferece
#   uma perspectiva mais clara das mudanças nos retornos diários das ações da Petrobrás.

plot(PETR4.SA.logs_diarios, main = 'Fechamento Diário das Ações da Petrobrás',
     col = 'red', xlab = 'Data', ylab = 'Retorno',
     major.ticks = 'months', minor.ticks = FALSE)


candleChart(PETR4.SA.logs_diarios)





# Salvando os dados em um arquivo .rds (arquivo em formato binário do R)

saveRDS(PETR4.SA, file = "PETR4.SA.rds")

# Carregando dados

Ptr = readRDS("PETR4.SA.rds")



























# Construindo gráfico com ggplot


library(ggplot2)
library(gridExtra)

# Obter dados da ação PETR4.SA
getSymbols("PETR4.SA", src = "yahoo", from = start_date, to = end_date, auto.assign = T)

# Converter os dados em um data frame
df <- as.data.frame(PETR4.SA)
View(df)
summary(df)

# Ajustar o formato dos dados
df <- data.frame(Date = index(df), df)
summary(df)

# Criar o gráfico de velas com ggplot2
candlestick_plot <- ggplot(df, aes(x = Date)) +
  geom_segment(aes(xend = Date, y = PETR4.SA.High, yend = PETR4.SA.Low), color = "black") +
  geom_rect(aes(xmin = Date - 0.2, xmax = Date + 0.2, ymin = PETR4.SA.Open, ymax = PETR4.SA.Close), fill = "white", color = "black") +
  labs(title = "Gráfico de Velas - PETR4.SA") +
  theme_minimal()

candlestick_plot

# Criar o gráfico do preço de fechamento
close_plot <- ggplot(df, aes(x = Date, y = PETR4.SA.Close)) +
  geom_line(color = "blue") +
  labs(title = "Preço de Fechamento - PETR4.SA") +
  theme_minimal()

close_plot

# Combinar os gráficos em um único painel
combined_plot <- grid.arrange(candlestick_plot, close_plot, nrow = 2)

# Exibir o gráfico combinado
combined_plot










# Criando uma lista de valores 
lista  <- c(5, 10, 15, 20, 25)              # variação maior entre os valores
lista2 <- c(2, 3, 2, 4, 2, 2, 3, 2, 2)      # variação menor entre os valores


# Calculando o desvio padrão
desvio_padrao <- sd(lista)
desvio_padrao2 <- sd(lista2)

mean(lista2)


# Exibindo o valor do desvio padrão
desvio_padrao
desvio_padrao2


plot(lista2, main = "Lista 2",
     col = 'red', xlab = 'Data', ylab = 'Preço')
addBBands(n = 20, sd = 2)



