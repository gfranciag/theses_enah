
library(openxlsx)
library(rvest)
library(tidyverse)
library(stringr)

setwd("D:/_2014-2022/2023/Redes_tesis")

# Obtener 20 url de 20 registros consulta Biblioteca Guillermo Bonfil B. "X7"   

# rvest guarda en "ref_tb" el atributo "html HREF" las URL de la hoja de 20 registros
ref_tb <-consulta_x7_bonfil %>%
  html_elements("a") %>% html_attr("href")
#resul
ref_tb <- as_tibble(ref_tb) 

###### Filtrar del objeto "ref_tb", obtener "/ENAH16/viewrec", y guardar "ref_tb_viewrec" 

ref_tb_viewrec <- ref_tb %>% 
  filter(str_detect(value, "/ENAH16/viewrec"))

# al objeto "ref_tb_viewrec" columna "value" se concatena al principio "https://bibliotecas.inah.gob.mx"
ref_tb_viewrec$value <- paste0("https://bibliotecas.inah.gob.mx", ref_tb_viewrec$value)

# === === === === === ===