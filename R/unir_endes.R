#' @title unir_endes
#'
#' @description Funcion para unir bases de datos de la ENDES
#'
#' @param base1 Base Endes o Enaho
#' @param base2 Base Endes o Enaho
#' @param tipo_union Tipo de unión (Hogar o Individual)
#'
#' @return Data.Frame
#'
#' @examples 
#' 
#' persona   <- consulta_endes(periodo = 2017, codigo_modulo = 64, 
#' base = "RECH1", guardar = FALSE, codificacion = "latin1")
#' 
#' salud     <- consulta_endes(periodo = 2017, codigo_modulo = 414, 
#' base = "CSALUD01", guardar = FALSE, codificacion = "latin1")
#' 
#' unir_endes(base1 = persona, base2 = salud, tipo_union = "individual")
#' 
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#'
#' @export unir_endes

unir_endes <- function(base1, base2, tipo_union = "individual") {
  
  if("CASEID" %in% names(base1)) {
    base1 <-  base1 %>% 
      dplyr::mutate(HHID = stringr::str_sub(.data$CASEID,1,
                                            (stringr::str_length(.data$CASEID)-3)),
             QSNUMERO = as.numeric(stringr::str_sub(.data$CASEID,-2,-1)))
  }
  
  if("CASEID" %in% names(base2)) {
    base2 <-  base2 %>% 
      dplyr::mutate(
        HHID = stringr::str_sub(.data$CASEID,1,
                                (stringr::str_length(.data$CASEID)-3)),
             QSNUMERO = as.numeric(stringr::str_sub(.data$CASEID,-2,-1)))
  }
  
  if("HVIDX"  %in% names(base1)) {
    base1 <- dplyr::rename(base1, QSNUMERO = .data$HVIDX)
  }
  
  if("HVIDX"  %in% names(base2)) {
    base2 <- dplyr::rename(base2, QSNUMERO = .data$HVIDX)
  }
  if("HC0"  %in% names(base1)) {
    base1 <- dplyr::rename(base1, QSNUMERO = .data$HC0)
  }
  
  if("HC0"  %in% names(base2)) {
    base2 <- dplyr::rename(base2, QSNUMERO = .data$HC0)
  }
  
  if("HA0"  %in% names(base1)) {
    base1 <- dplyr::rename(base1, QSNUMERO = .data$HA0)
  }
  
  if("HA0"  %in% names(base2)) {
    base2 <- dplyr::rename(base2, QSNUMERO = .data$HA0)
  }
  
  if(tipo_union == "individual")  {
    dplyr::left_join(base1,base2, by = c("HHID","QSNUMERO"))
  } 
  
  else if(tipo_union == "hogar") {
    dplyr::left_join(base1,base2, by = "HHID")
  }
  
  else {
    print("tipo_union invalida, ingrese 'individual' u 'hogar'")
  }
}
