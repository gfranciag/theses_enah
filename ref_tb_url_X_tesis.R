# Este código sólo obtiene las URL de 1188 tesis de arquología
# de 1946 a 2022
# Consulta a la B. G. Bonfil Batalla de la ENAH con la clasficacion X7 licenciatura
# Usa un XLSX con el listado de 60 consutlas y extraer las URL de 1188 tesis
# 
# El resultado se usa para luego extraer toda la metadata de cada 1188 
# de las tesis de licenciatura en arqueologia


# Obtener registros de X7 biblioteca Bonfil Batalla -----------------------
library(openxlsx)
library(rvest)
library(tidyverse)

# el directorio de trabajo
setwd("D:/_2014-2022/2023/Redes_tesis")

# Leer las urls desde el archivo xlsx
url <- readxl::read_excel("D:/_2014-2022/2023/Redes_tesis/url20tesisxhoja.xlsx")

# Crear objeto vacio como lista acá irán los resultados
datos <- list()

# Iterar sobre cada url del archivo "url20tesisxhoja.xlsx"
for(i in 1:length(url$url)){
  
  # Lee página Biblioteca G. Bonfin B usando función "read_html" de "rvest"
  consulta_x7_bonfil <- read_html(url$url[i])
    
  ### Obtener url de 20 tesis, obtener "ref_tb" y los guarda "ref_tb_viewrec" -----
  # rvest obtiene objeto html HREF las URL de la hoja de 20 registros
  ref_tb <-consulta_x7_bonfil %>%
    html_elements("a") %>% html_attr("href")
  
  ref_tb <- as_tibble(ref_tb) 
  
  # Filtrar del objeto "ref_tb", obtener "/ENAH16/viewrec", y guardar "ref_tb_viewrec" 
  
  ref_tb_viewrec <- ref_tb %>% 
    filter(str_detect(value, "/ENAH16/viewrec"))
  
  # al objeto "ref_tb_viewrec" columna "value" se concatena al 
  # principio "https://bibliotecas.inah.gob.mx"
  
  ref_tb_viewrec$value <- paste0("https://bibliotecas.inah.gob.mx", ref_tb_viewrec$value)
  
  # Varaible "datos" está vacia, "bind_rows" agrega los "viewrec" 
  # los "ref_tb_viewrec" a "datos" de 20 en 20 hasta 1188 URL de tesis  
  datos <- bind_rows(ref_tb_viewrec, datos)
  
  # tiempo de espera varable de entre 15 y 30 segundos, es lento, pero 
  # evita que el servidor te rechace
  wait_time <- runif(1, 15, 30)
  Sys.sleep(wait_time)
  
  }

# Convierte el resultado de la variable "datos" obtenida del FOR
# y la convierte un objeto tibble
ref_tb_viewrec <- tibble(datos) 

# Guardar en excel
rio::export(ref_tb_viewrec1,"ref_tb_viewrec.xlsx")
  
# === FIN de código === === === === ===
  
