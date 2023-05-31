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



# - Uma série temporal é uma sequência de observações coletadas em intervalos de tempo regular, como horas, dias, semanas, meses ou anos.

# - A análise de séries temporais tem como objetivo identificar padrões, tendências e estruturas subjacentes nos dados ao longo do tempo,
#   bem como fazer previsões sobre o seu comportamento futuro. Ela é amplamente utilizada em diversos campos, incluindo economia,
#   finanças, meteorologia, ciências sociais, engenharia, entre outros.

# - A análise de séries temporais no mercado financeiro é uma aplicação bastante relevante e útil. Ela permite estudar e prever o
#   comportamento de indicadores financeiros ao longo do tempo, como preços de ações, índices de mercado, taxas de juros, entre outros.




