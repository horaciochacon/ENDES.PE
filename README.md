# ENDES.PE

ENDES.PE es un paquete de manejo y obtención de información de la Encuesta Demográfica y de Salud Familiar del Perú. Este paquete permite la descarga de las Bases de Datos de la ENDES desde el portal Microdatos de [INEI](http://iinei.inei.gob.pe/microdatos/). 

## Instalación

Para instalar el paquete en R por medio del repositorio en [Github](https://github.com/horaciochacon/ENDES.PE) ejecutar el comando:

```s
devtools::install_github("horaciochacon/ENDES.PE")
```

## Uso de consulta_endes()

La función **consulta_endes()** descarga la información de la web de [INEI](http://iinei.inei.gob.pe/microdatos/) en formato .sav. Los argumentos necesarios son:

1. *periodo:* El año de la encuesta (por ejemplo "2015")
2. *codigo_modulo:* El codigo del módulo de la encuesta según la web de INEI (por ejemplo "64","65","413", etc.)
3. *base:* La base de datos específica que se quiere descargar (por ejemplo "RECH1","RECH0", etc.)
4. *guardar:* Si se desea descargar el archivo .sav o se quiere cargar como data frame directamente (usando read_sav del paquete *haven*)
5. *ruta:* Si guardar es TRUE, cuál será la ruta donde se descargará. Esta es la ruta tomando como base el working directory (../**ruta**)

### Ejemplo

```s
# Guardando la base de datos en el la carpeta "Data" del area de trabajo (working directory)
consulta_endes(periodo = 2015, codigo_modulo = 64, base = "RECH1", guardar = TRUE, ruta = "Data")

# Cargando las base de datos 

salud     <- consulta_endes(periodo = 2017, codigo_modulo = 414, base = "CSALUD01", guardar = FALSE)
persona   <- consulta_endes(periodo = 2017, codigo_modulo = 64, base = "RECH1", guardar = FALSE)
vivienda  <- consulta_endes(periodo = 2017, codigo_modulo = 65, base = "RECH23", guardar = FALSE)
hogar     <- consulta_endes(periodo = 2017, codigo_modulo = 64, base = "RECH0", guardar = FALSE)

```

## Uso de unir_endes()

La función **unir_endes()** permite la unión (tipo left_join) de dos bases de datos de la ENDES. Los argumentos de la función son:

1. *base1:* Base de datos número 1.
2. *base2:* Base de datos número 2.
3. *tipo_union:* Si el argmento es "individual" la unión se hace al nivel de individuo, si el argumento es "hogar", la unión se realiza a nivel de hogar.

### Ejemplo

```s
# Utilizando las bases del ejemplo anterior unimos base de personas ("individual")
union_individios <- unir_endes(base1 )

# Cargando la base de datos en el Data frame "Datos"
Datos <- consulta_endes(periodo = 2012, codigo_modulo = 64, base = "RECH1", guardar = FALSE)
```


## Información adicional

Este es un paquete experimental, los datos e información obtenida no son reponsabilidad del desarrollador.
Para mayor información revisar la documentación de la ENDES en la página de INEI.

## Contacto

* Horacio Chacón-Torrico
* horacio.chacon.t@upch.pe



