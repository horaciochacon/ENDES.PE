# ENDES.PE

ENDES.PE es un paquete de manejo y obtención de información de la Encuesta Demográfica y de Salud Familiar del Perú. Este paquete permite la descarga de infromación desde la web de [INEI](http://iinei.inei.gob.pe/microdatos/). 

## Instalación

Para instalar el paquete en R por medio del repositorio en [Github](https://github.com/horaciochacon/ENDES.PE) ejecutar el comando:

```s
devtools::install_github("horaciochacon/ENDES.PE")
```

## Uso

La función **consulta_endes()** descarga la información de la web de [INEI](http://iinei.inei.gob.pe/microdatos/) en formato .sav. Los argumentos necesarios son:

1. *periodo:* El año de la encuesta (por ejemplo "2015")
2. *codigo_modulo:* El codigo del módulo de la encuesta según la web de INEI (por ejemplo "64","65","413", etc.)
3. *base:* La base de datos específica que se quiere descargar (por ejemplo "RECH1","RECH0", etc.)
4. *guardar:* Si se desea descargar el archivo .sav o se quiere cargar como data frame (usando read.spss del paquete *foreign*)
5. *ruta:* Si guardar es TRUE cual será la ruta donde se descargará. Esta es la ruta a partir del working directory (/working/directory/**ruta**)

### Ejemplo

```s
# Guardando la base de datos en el la carpeta "Data" del area de trabajo (working directory)
consulta_endes(periodo = 2015, codigo_modulo = 64, base = "RECH1", guardar = TRUE, ruta = "Data")

# Cargando la base de datos en el Data frame "Datos"
Datos <- consulta_endes(periodo = 2012, codigo_modulo = 64, base = "RECH1", guardar = FALSE)
```

## Información adicional

Para mayor información revisar la documentación de la ENDES en la página de INEI.

Pronto nuevas funciones para el manejo de los datos de la ENDES...

## Contacto

* Horacio Chacón-Torrico
* horacio.chacon.t@upch.pe



