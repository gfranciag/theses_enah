# Paquetes ----------------------------------------------------------------

library(openxlsx)
library(rvest)
library(tidyverse)


# el directorio de trabajo
setwd("D:/_2014-2022/2023/Redes_tesis")

# obtener metadata de una sola tesis----------------------------------------------------------------------

# web de una sola tesis  tesis 
tbmetadato <- read_html("https://bibliotecas.inah.gob.mx/ENAH16/viewrec?nr=000X01154&nc=7&sk=0&no=1&rf=0&nf=3&tr=23&ns=2804&nc=7&sk=0&no=1&rf=0&tr=23&nf=3")

# rvest obtiene objeto html en texto para la lista tbmetadago
tbmetadato %>%
  html_text()
# rvest obtiene objeto html tabla con metadata de tesis
tb_tesis <- tbmetadato %>%
  html_table()
# sólo elegir la tabla 4 de 7, porque tiene la metadata
tb_tesis[[4]]
# tabla 4 asingada a dataframe el dc (descripcion/concepto)
dc <- tb_tesis[[4]]
# elimina la primer fila, y las columnas de la 3 a la 37
dc <- dc[-c(1,2),-(3:37)]

# a un tibble y trasponer
horizontal <- as_tibble(dc) %>% t()
# vuelve a ser tibble
horizontal1 <- as_tibble(horizontal)


#extrae datos tesis
unregistro <- slice(horizontal1, 2)
#junta todo y va sumando en todas tesis
todastesis <- bind_rows(horizontal1, unregistro)












# Obtener registros de X7 biblioteca Bonfil Batalla -----------------------


# web de los primeros 20 registros de consulta X7 
consulta_x7_bonfil <- read_html("https://bibliotecas.inah.gob.mx/ENAH16/results?nc=2&sk=20&no=1&rf=0&nf=3&tr=1188&ns=2804&nc=2&sk=0&no=1&rf=0&tr=1188&nf=3")

# rvest obtiene objeto html en texto para la lista consulta X7
consulta_x7_bonfil %>%
  html_text()

# Extrae el listado en vertical
tabla <-consulta_x7_bonfil %>%
  html_nodes(".td1:nth-child(11) , .td1:nth-child(4) , .td1:nth-child(3) , .td1:nth-child(2)") %>%
  html_text()

view(tabla)

tabla_tb <- as_tibble(tabla)
rio::export(tabla_tb,"tabla_tb.xlsx")


# Obtener url de 20 tesis y un ref_tb -------------------------------------

####### Obtener las url de cada una de las 20 tesis  
#   --
# rvest obtiene objeto html tabla con metadata de tesis
ref_tb <-consulta_x7_bonfil %>%
  html_elements("a") %>% html_attr("href")

view(ref_tb)
# 
ref_tb <- as_tibble(ref_tb) 
# 
ref_tb <- filter(value == "/ENAH16/viewrec")


#Filtar y solo obtener el "/ENAH16/viewrec",


# además concatenar url y el viewrec



# Guardar en excel
rio::export(ref_tb,"ref_tb.xlsx")
