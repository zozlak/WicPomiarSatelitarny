#' Wczytuje do R zdjęcia o wskazanej dacie ze wskazanego katalogu
#' @details Funkcja zakłada, że zdjęcia mają nazwy takie, jakie nadawaje funkcja
#' \link{pobierzZdjecia}.
#' @param katalog katalog, w którym znajdują się zdjęcia do wczytania
#' @param data data zdjęć, które mają być wczytan
#' @param skorAtm decyduje, czy wczytać zdjęcia skorygowane czy nieskorygowane
#'   atmosferycznie (TRUE/FALSE, domyślnie TRUE)
#' @return lista z wczytanymi zdjęciami indeksowana nazwami pasm
#' @export
wczytajZdjecia = function(katalog, data, skorAtm = TRUE){
  regExp = sprintf('^%s_[A-Z0-9]+%s.tif$', data, ifelse(skorAtm, '', '_raw'))
  pliki = list.files(katalog, regExp)
  pasma = sub('^.*_([A-Z0-9]+).*$', '\\1', pliki)
  
  zdjecia = list()
  for(i in seq_along(pliki)){
    zdjecia[[pasma[i]]] = raster::raster(paste0(katalog, '/', pliki[i]))
  }
  
  return(zdjecia)
}