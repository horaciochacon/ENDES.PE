#' @title diccionario_encuesta
#'
#' @description Funcion para generar diccionario de variables con las bases de datos de la ENDES o ENAHO.
#'
#' @param base_endes Base Endes o Enaho
#'
#' @return tibble
#'
#' @examples 
#' 
#' endes <- consulta_endes(periodo = 2012,codigo_modulo = '64',
#' base = 'RECH1', guardar = FALSE, codificacion = "UTF-8")
#' diccionario_encuesta(base_endes=endes)
#' 
#' enaho <- consulta_enaho(periodo = 2017, codigo_modulo = "01", 
#' base = "Enaho01-2017-100", guardar = FALSE, codificacion = "latin1")
#' 
#' diccionario_encuesta(base_endes=enaho)
#'
#'@importFrom magrittr %>%
#'@importFrom rlang .data
#'
#' @export diccionario_encuesta
#' 

diccionario_encuesta <- function(base_endes) {
  base_endes %>% 
    sjlabelled::as_factor() %>% 
    labelled::look_for(details = TRUE) %>% 
    dplyr::as_tibble() %>% 
    dplyr::select(.data$variable,class,.data$label,levels) %>% print(n=Inf)
}
