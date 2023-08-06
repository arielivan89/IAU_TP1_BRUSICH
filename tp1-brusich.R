library(tidyverse)
library(haven)
## Trabajare con un dataset del GCBA con los registros de obras privadas entre los años 2017 y 2019. Se trata de un CSV separado por punto y coma, utilizo read_csv2
obras_registradas <- read_csv2 ("obrasregistradas-acumulado.csv")
##Se trata de un dataset con 12 variables y 28691 registros. Inspecciono el dataset para conocer sus columnas
head(obras_registradas)
##Me interesa trabajar con demoliciones para saber cual es el promedio por comuna. 
##Como las columnas de tipo de obra y comuna son del tipo "character" las convertire en factor para poder identificarlas.
obras_registradas_1 <- mutate(obras_registradas, comuna=as.factor(comuna), tipo_obra=as.factor(tipo_obra))
##A continuación filtraré los permisos de demolicion registrados.
demoliciones <- filter(obras_registradas_1, tipo_obra=="PERMISO DE DEMOLICION")
## Para poder contar, agrupare por comuna y contare las demoliciones registradas.
demoliciones_por_comuna <- demoliciones %>%
  group_by(comuna) %>%
  summarise(tipo_obra=n())
##La comuna con mas demoliciones registradas es la Comuna 11. Ahora quiero saber cual es el promedio de demoliciones por comunas.
mean(demoliciones_por_comuna$tipo_obra)
##El promedio de demoliciones es de 81,37.