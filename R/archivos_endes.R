#' @title archivos_endes
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
#' archivos_endes(periodo=2017, codigo_modulo="64")
#'
#' @export archivos_endes

archivos_endes <- function(periodo, codigo_modulo) {
  
  # Generamos dos objetos temporales: un archivo y una carpeta 
  temp <- tempfile() ; tempdir <- tempdir()
  
  # Genera una matriz con el número identificador de versiones por cada año
  versiones <- matrix(c(2018, 638, 2017,605,2016,548,2015,504,2014,441,
                        2013,407,2012,323,2011,290,2010,260,
                        2009,238,2008,209,2007,194,2006,183,
                        2005,150,2004,120),byrow = T,ncol = 2)
  
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
