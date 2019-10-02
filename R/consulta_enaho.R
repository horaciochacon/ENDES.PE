#' @title consulta_enaho
#'
#' @description Funcion para extraer bases de datos de la Encuesta Nacional de Hogares.
#'
#' @param periodo,codigo_modulo,base,guardar,ruta,codificacion
#'
#' @return archivo .sav o Data Frame (Segun parametro guardar)
#'
#' @examples consulta_enaho(periodo = 2017, codigo_modulo = "01", base = "Enaho01-2017-100", guardar = FALSE)
#'
#' @export consulta_enaho

consulta_enaho <- function(periodo, codigo_modulo, base, guardar = FALSE, ruta = "", codificacion=NULL) {
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
  download.file(url,temp)
  
  # Listamos los archivos descargados y seleccionamos la base elegida
  archivos <- unzip(temp,list = T)
  archivos <- archivos[stringr::str_detect(archivos$Name, paste0(base,"\\.")) == TRUE,]
  
  # Elegimos entre guardar los archivos o pasarlos directamente a un objeto
  if(guardar == TRUE) {
    unzip(temp, files = archivos$Name, exdir = paste(getwd(), "/", ruta, sep = ""))
    print(paste("Archivos descargados en: ", getwd(), "/", ruta, sep = ""))
  } 
  # else if (periodo == 2014) {
  #   endes <- read_sav(unzip(temp, files = archivos$Name, exdir = tempdir))
  #   nombres <- toupper(colnames(endes))
  #   colnames(endes) <- nombres
  #   endes
  # } 
  else {
    endes <- read_sav(unzip(temp, files = archivos$Name, exdir = tempdir), encoding = codificacion)
    nombres <- toupper(colnames(endes))
    colnames(endes) <- nombres
    endes
  }
}
