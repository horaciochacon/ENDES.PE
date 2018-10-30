#' @title consulta_endes
#'
#' @description Funcion para extraer bases de datos de la Encuesta Nacional Demografica y de Salud familiar.
#'
#' @param periodo,codigo_modulo,base,guardar,ruta
#'
#' @return archivo .sav o Data Frame (Segun parametro guardar)
#'
#' @examples consulta_endes(periodo = 2012,codigo_modulo = '64',base = 'RECH1', guardar = F)
#'
#' @export consulta_endes

consulta_endes <- function(periodo, codigo_modulo, base, guardar = FALSE, ruta = "") {
  # Generamos dos objetos temporales: un archivo y una carpeta 
  temp <- tempfile() ; tempdir <- tempdir()
  
  # Genera una matrix con el número identificador de versiones por cada año
  versiones <- matrix(c(2017,605,2016,548,2015,504,2014,441,2013,407,2012,323,2011,290,2010,260),byrow = T,ncol = 2)
  
  # Extrae el código de la encuesta con la matriz versiones
  codigo_encuesta <- versiones[versiones[,1] == periodo,2]
  ruta_base <- "http://iinei.inei.gob.pe/iinei/srienaho/descarga/SPSS/" # La ruta de microdatos INEI
  modulo <- paste("-modulo",codigo_modulo,".zip",sep = "")
  url <- paste(ruta_base,codigo_encuesta,modulo,sep = "")
  
  # Descargamos el archivo
  download.file(url,temp)
  
  # Listamos los archivos descargados y seleccionamos la base elegida
  archivos <- unzip(temp,list = T)
  archivos <- archivos[str_detect(archivos$Name, base) == TRUE,]
  
  # Elegimos entre guardar los archivos o pasarlos directamente a un objeto
  if(guardar == TRUE) {
    unzip(temp, files = archivos$Name, exdir = paste(getwd(), "/", ruta, sep = ""))
    print(paste("Archivos descargados en: ", getwd(), "/", ruta, sep = ""))
  } else {
    endes <- read_sav(unzip(temp, files = archivos$Name, exdir = tempdir), encoding = 'UTF-8')
    nombres <- toupper(colnames(endes))
    colnames(endes) <- nombres
    endes
  }
}


