# Este código obtiene toda la metadata de las 154 tesis de arquología
# de 1946 a 2022
# Consulta la B. G. Bonfil Batalla de la ENAH con la clasficacion X7A maestria
# Usa un XLSX con el listado de 154 consutlas y
# extraer la metadata en de las 154 tesis en un archivo de XLSX
# 
# de las tesis de licenciatura en arqueologia

# Obtener registros de X7 biblioteca Bonfil Batalla -----------------------
library(openxlsx)
library(rvest)
library(tidyverse)

# el directorio de trabajo
setwd("D:/_2014-2022/2023/Redes_tesis/mtr_arq_x7a")

# Leer urls de 1188 tesis desde el archivo xlsx
url <- readxl::read_excel("D:/_2014-2022/2023/Redes_tesis/mtr_arq_x7a/url_ref_tb_viewrec_x7a.xlsx")

# Crear un objeto "tesis" vacio para guardar los resultados
todastesis <- list()

# Iterar sobre cada url
for(i in 1:length(url$url)){
  
  # Descargar cada ficha de tesis X7 de Biblioteca G. Bonfil Batalla
  # y guardar en "pagina" el "html" con "read_html" de "rvest"
  tbmetadata <- read_html(url$url[i])
  
    # Extraer la metadata de cada tesis necesarios y guardarlos en el objeto "tesis"
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

  # tiempo de espera varable de entre 15 y 30 segundos, es lento, pero 
  # evita que el servidor te rechace
  wait_time <- runif(1, 1, 15)
  Sys.sleep(wait_time)
    
}

# Convertir en un objeto tibble todos los resultados

tesis_tibble <- tibble(todastesis)

# 
# exportar a un archivo XLS las tesis X7 de lic. Arqueología
rio::export(tesis_tibble,"todas_las_tesis_x7a.xlsx")


