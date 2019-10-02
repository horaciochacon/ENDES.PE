#' @title diccionario_encuesta
#'
#' @description Funcion para generar diccionario de variables con las bases de datos de la ENDES o ENAHO.
#'
#' @param base_endes
#'
#' @return tibble
#'
#' @examples 
#' 
#' endes <- consulta_endes(periodo = 2012,codigo_modulo = '64',base = 'RECH1', guardar = F)
#' diccionario_encuesta(base_endes=endes)
#' 
#' enaho <- consulta_enaho(periodo = 2017, codigo_modulo = "01", base = "Enaho01-2017-100", guardar = FALSE)
#' diccionario_encuesta(base_endes=enaho)
#'
#' @export diccionario_encuesta

diccionario_encuesta <- function(base_endes) {
  base_endes %>% 
    as_factor() %>% 
    look_for(details = T) %>% 
    mutate(
      #retirar luego de corregir utf-8
      #label=make_clean_names(label)
    ) %>% 
    as_tibble() %>% 
    select(variable,class,label,levels) %>% print(n=Inf)
}
