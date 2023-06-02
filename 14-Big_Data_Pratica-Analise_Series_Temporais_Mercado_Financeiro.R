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

?plot
























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


