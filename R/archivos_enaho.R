#' @title archivos_enaho
#'
#' @description Funcion para listar archivos disponibles en cada módulo por periodo de la base de datos de la ENDES o ENAHO.
#'
#' @param periodo Año de la encuesta
#' @param codigo_modulo Código del módulo
#'
#' @return tibble
#'
#' @examples 
#' 
#' archivos_enaho(periodo=2017, codigo_modulo="01")
#'
#' @export archivos_enaho

archivos_enaho <- function(periodo, codigo_modulo) {
  
  # Generamos dos objetos temporales: un archivo y una carpeta 
  temp <- tempfile() ; tempdir <- tempdir()
  
  # Genera una matriz con el número identificador de versiones por cada año
  versiones <- matrix(c(2018, 634, 
                        2017,603,
                        2016,546,
                        2015,498,
                        2014,440,
                        2013,404,
                        2012,324,
                        2011,291,
                        2010,279,
                        2009,258,
                        2008,284,
                        2007,283,
                        2006,282,
                        2005,281,
                        2004,280
  ),byrow = T,ncol = 2)
  
  # Extrae el código de la encuesta con la matriz versiones
  codigo_encuesta <- versiones[versiones[,1] == periodo,2]
  ruta_base <- "http://iinei.inei.gob.pe/iinei/srienaho/descarga/SPSS/" # La ruta de microdatos INEI
  modulo <- paste("-modulo",codigo_modulo,".zip",sep = "")
  url <- paste(ruta_base,codigo_encuesta,modulo,sep = "")
  
  # Descargamos el archivo
  utils::download.file(url,temp)
  
  # Listamos los archivos descargados y seleccionamos la base elegida
  archivos <- utils::unzip(temp,list = T)
  
  return(archivos)
  
}
