#' @title consulta_endes
#'
#' @description Funcion para extraer bases de datos de la Encuesta Nacional Demografica y de Salud familiar.
#'
#' @param periodo Año de la encuesta
#' @param codigo_modulo Código del módulo
#' @param base Nombre de base de datos
#' @param guardar Logical 
#' @param ruta Ruta para guardar archivo
#' @param codificacion Codificación (UTF-8, latin1, etc.)
#'
#' @return archivo .sav o Data Frame (Segun parametro guardar)
#'
#' @examples consulta_endes(periodo = 2012,codigo_modulo = '64',base = 'RECH1', 
#' guardar = FALSE, codificacion = "UTF-8")
#'
#' @export consulta_endes

consulta_endes <- function(periodo, codigo_modulo, base, guardar = FALSE, ruta = "", codificacion=NULL) {
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
  archivos <- archivos[stringr::str_detect(archivos$Name, paste0(base,"\\.")) == TRUE,]
  
  # Elegimos entre guardar los archivos o pasarlos directamente a un objeto
  if(guardar == TRUE) {
    utils::unzip(temp, files = archivos$Name, exdir = paste(getwd(), "/", ruta, sep = ""))
    print(paste("Archivos descargados en: ", getwd(), "/", ruta, sep = ""))
  } 
  else {
    endes <- haven::read_sav(utils::unzip(temp, files = archivos$Name, 
                                          exdir = tempdir), 
                             encoding = codificacion)
    nombres <- toupper(colnames(endes))
    colnames(endes) <- nombres
    endes
  }
}


