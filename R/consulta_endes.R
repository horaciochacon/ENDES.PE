#' @title Importa bases de datos de la ENDES
#'
#' @description Paquete que permite importar bases de datos de ENDES
#'
#' @param periodo, codigo_modulo, base
#'
#' @return data.frame
#'
#' @examples consulta_endes(periodo = 2012,codigo_modulo = '64',base = 'RECH1')
#'
#' @export consulta_endes

consulta_endes <- function(periodo, codigo_modulo, base) {
  versiones <- matrix(c(2017,605,2016,548,2015,504,2014,441,2013,
                        407,2012,323,2011,290,2010,260),byrow = T,ncol = 2)
  codigo_encuesta <- versiones[versiones[,1] == periodo,2]
  ruta_base <- 'http://iinei.inei.gob.pe/iinei/srienaho/descarga/SPSS/'
  modulo <- paste('-modulo',codigo_modulo,'.zip',sep = '')
  filename <- paste(ruta_base,codigo_encuesta,modulo,sep = '')
  temp <- tempfile()
  download.file(filename,temp)
  archivos <- unzip(temp,list = T)
  archivos <- archivos[str_detect(archivos$Name, base) == TRUE,]
  DF <-unzip(temp,files = archivos$Name)
  read.spss(DF,to.data.frame = T)
}



