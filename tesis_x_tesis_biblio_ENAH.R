
# Paquetes ----------------------------------------------------------------

library(openxlsx)
library(rvest)
library(tidyverse)


# el directorio de trabajo
setwd("D:/_2014-2022/2023/Redes_tesis")

# obtener metadata de la primera tesis----------------------------------------------------------------------

# web de una sola tesis  tesis 
tbmetadata <- read_html("https://bibliotecas.inah.gob.mx/ENAH16/viewrec?nr=000X00792&ns=2804&nc=5&sk=0&no=1&rf=0&tr=1181&nf=3")

# rvest obtiene objeto html tabla con metadata "descripcion" de tesis
tb_tesis <- tbmetadata %>% 
  html_table(trim=TRUE)

# sólo elegir la tabla 4 de 7, porque tiene la metadata
tb_tesis[[4]]
# tabla 4 asingada a dataframe el dc (descripcion/concepto)
dc <- tb_tesis[[4]]
# elimina la primer fila, y las columnas de la 3 hasta la última del registro
dc <- dc[-c(1,2),-(3:ncol(dc))]

# convierte a un tibble y trasponer
dc <- as_tibble(dc) %>% t()

dc1 <- as_tibble(dc)
dc1 <- slice(dc1, 1)

dc2 <- as_tibble(dc)
dc2 <- slice(dc2, 2)

todastesis <- bind_rows(dc1,dc2)
todastesis <- as_tibble(todastesis)

# # obtener las restantes, segunda hasta la n tesis   ---------------------

tbmetadata <- read_html("https://bibliotecas.inah.gob.mx/ENAH16/viewrec?nr=000X00201&ns=2804&nc=2&sk=20&no=1&rf=0&tr=1188&nf=3")

# rvest obtiene objeto html tabla con metadata "descripcion" de tesis
tb_tesis <- tbmetadata %>% 
  html_table(trim=TRUE)

# sólo elegir la tabla 4 de 7, porque tiene la metadata
tb_tesis[[4]]
# tabla 4 asingada a dataframe el dc (descripcion/concepto)
dc <- tb_tesis[[4]]
# elimina la primer fila, y las columnas de la 3 hasta la última del registro
dc <- dc[-c(1,2),-(3:ncol(dc))]

# convierte a un tibble y trasponer
dc <- as_tibble(dc) %>% t()
dc <- as_tibble(dc)
dc3 <- slice(dc, 2)

#### concatenar

todastesis <- bind_rows(todastesis,dc3)


# ---
# ---
# ---
























#### reinicia un paso arriba 2 a la n tesis
















##########################
x7 <- as_tibble(todastesis)
rio::export(tabla_tb,"x7.xlsx")



# Obtener registros de X7 biblioteca Bonfil Batalla -----------------------


# web de los primeros 20 registros de consulta X7 
consulta_x7_bonfil <- read_html("https://bibliotecas.inah.gob.mx/ENAH16/results?nc=6&sk=0&no=1&rf=0&nf=3&tr=1181&ns=2804&nc=6&sk=20&no=1&rf=0&tr=1181&nf=3")



# codigo para reusar ------------------------------------------------------

tbmetadato <- read_html("https://bibliotecas.inah.gob.mx/ENAH16/viewrec?nr=000X00792&ns=2804&nc=5&sk=0&no=1&rf=0&tr=1181&nf=3")



# Escribir los resultados en un archivo xlsx
# wb <- createWorkbook()
# addWorksheet(wb, sheetName = "Resultados")
# writeData(wb, sheet = "Resultados", x = resultados, startCol = 1, startRow = 1)
# saveWorkbook(wb, "no.xlsx", overwrite = TRUE)



