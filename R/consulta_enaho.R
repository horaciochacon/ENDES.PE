#' @title consulta_enaho
#'
#' @description Funcion para extraer bases de datos de la Encuesta Nacional de Hogares.
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
#' @examples consulta_enaho(periodo = 2017, codigo_modulo = "01", base = "Enaho01-2017-100", guardar = FALSE)
#'
#' @export consulta_enaho

consulta_enaho <- function(periodo, codigo_modulo, base, guardar = FALSE, ruta = "", codificacion=NULL) {
  # Generamos dos objetos temporales: un archivo y una carpeta 
  temp <- tempfile() ; tempdir <- tempdir()
  
  # Genera una matriz con el número identificador de versiones por cada año
  versiones <- matrix(c(2025,1031,
                        2024,966,
                        2023,906,
                        2022,784,
                        2021,759,
                        2020,737,
                        2019,687, 
                        2018,634, 
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
  ruta_base <- "https://proyectos.inei.gob.pe/iinei/srienaho/descarga/SPSS/" # La ruta de microdatos INEI
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
    sav <- utils::unzip(
      temp,
      files = archivos$Name[grepl(".sav|.SAV", archivos$Name)]
    )
    endes <- tryCatch(
      haven::read_sav(sav, encoding = codificacion),
      error = \(e) {
      # INEI tiene en algunos archivos codificacion windows-1252, pero algunos datos de texto se encuentran fuera de ese rango
      if (!is.null(codificacion) || !grepl("encoding", conditionMessage(e))) stop(e)
      warning("El archivo no se pudo leer con la codificacion declarada; se usa codificacion = \"latin1\"", call. = FALSE)
      haven::read_sav(sav, encoding = "latin1")
      }
    )
    nombres <- toupper(colnames(endes))
    colnames(endes) <- nombres
    endes
  }
}
