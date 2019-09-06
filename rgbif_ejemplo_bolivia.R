# Librerias

library(rgbif)
library(tidyverse)

##Buscar taxonomia en Bolivia
#El codigo para Bolivia
bol_code <- isocodes[grep("Bolivia", isocodes$name), "code"]

#
occ_count(country=bol_code)

list_sciNames <- c("Cissia Doubleday", "Synallaxis rutilans Temminck", "Bombus opifex Smith",         
                   "Phulia nymphula", "Boana Gray", "Eurytides dolicaon" )

#name
bol_data_taxonomy <- lapply(list_sciNames, function(x){
    occ_search(scientificName = list_sciNames, country = bol_code, return = 'data')
  })


##buscar los key de los nombres de la lista de especies
keys <- lapply(list_sciNames, function(x) name_suggest(x, rank = "species"))%>%
  bind_rows()%>%
  dplyr::select(key)%>%
  unlist(use.names = F)


#descarga de gbif a partir de los key con los campos minimos(specie, key, decimallatitude, decimallongitude)
bolivia.occ <- occ_search(taxonKey = keys, limit=2000, return="data", 
                          continent = c('south_america'), fields = 'minimal', hasCoordinate = TRUE)

##aca se puede cambiar el limite de records segun su manual se puede descargar un maximo de 200000