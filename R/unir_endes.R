#' @title unir_endes
#'
#' @description Funcion para unir bases de datos de la ENDES
#'
#' @param x,y, tipo de union
#'
#' @return Data.Frame
#'
#' @examples 
#'
#' @export unir_endes

unir_endes <- function(base1, base2, tipo_union = "individual") {
  
  if("CASEID" %in% names(base1)) {
    base1 <-  base1 %>% 
      mutate(HHID = str_sub(CASEID,1,(str_length(CASEID)-3)),
             QSNUMERO = as.numeric(str_sub(CASEID,-2,-1)))
  }
  
  if("CASEID" %in% names(base2)) {
    base2 <-  base2 %>% 
      mutate(HHID = str_sub(CASEID,1,(str_length(CASEID)-3)),
             QSNUMERO = as.numeric(str_sub(CASEID,-2,-1)))
  }
  
  if("HVIDX"  %in% names(base1)) {
    base1 <- rename(base1, QSNUMERO = HVIDX)
  }
  
  if("HVIDX"  %in% names(base2)) {
    base2 <- rename(base1, QSNUMERO = HVIDX)
  }
  
  if(tipo_union = "individual")  {
    left_join(base1,base2, by = c("HHID","QSNUMERO"))
  } 
  
  else if(tipo_union = "hogar") {
    left_join(base1,base2, by = "HHID")
  }
  
  else {
    print("tipo_union inválida, ingrese \"individual\" u \"hogar\"")
  }
}
