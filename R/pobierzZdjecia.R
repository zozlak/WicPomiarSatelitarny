#' Pobiera zdjęcia obejmujące wskazany punkt we wskazanym czasie
#' @details Dokładniej pobierane są wszystkie zdjęcia w rozdzielczości 60 m /
#' piksel.
#' 
#' Zdjęcia zapisywane są pod nazwami "data_nazwaPasma.tiff" (skorygowane 
#' atmosferycznie) oraz "data_nazwaPasma_raw.tiff" (nieskorygowane 
#' atmosferycznie).
#' @param dlGeogr Długość geograficzna w stopniach. Długość E ma wartości
#'   dodatnie, długość W ujemne.
#' @param szGeogr Szerokość geograficzna w stopniach. Szerokość N ma wartości
#'   dodatnie, szerokość S ujemne.
#' @param dataOd data początku okresu, dla którego mają być pobrane zdjęcia w
#'   formacie RRRR-MM-DD
#' @param dataDo data końca okresu, dla którego mają być pobrane zdjęcia w
#'   formacie RRRR-MM-DD
#' @param katalog katalog, do którego zapisane zostaną zdjęcia (domyślnie obecny
#'   katalog roboczy)
#' @param method metoda pobierania plików (patrz parametr \code{method} funkcji 
#'   \code{\link[utils]{download.file}})
#' @return ramka danych opisująca pobrane zdjęcia
#' @import dplyr
#' @export
pobierzZdjecia = function(dlGeogr, szGeogr, dataOd, dataDo, progChmur = 50, katalog = '.', method = 'auto'){
  req = httr::GET(
    'http://s2.boku.eodc.eu/image',
    query = list(
      'dateMin' = dataOd, 
      'dateMax' = dataDo, 
      'cloudCovMax' = progChmur,
      'geometry' = sprintf('{"type":"Point","coordinates":[%f, %f]}', dlGeogr, szGeogr)
    ),
    username =  'WIC',
    password = 'pulawy2016'
  )
  images = jsonlite::fromJSON(httr::content(req, 'text')) %>%
    select_('imageId', 'date', 'atmCorr', 'band', 'resolution', 'orbit', 'url') %>%
    group_by_('band', 'atmCorr') %>%
    filter_(~resolution == min(resolution)) %>%
    mutate_(
      url = ~paste0(url, '?resolution=60&dataType=Int16'),
      file = ~paste0(katalog, '/', substr(date, 1, 10), '_', band, ifelse(atmCorr > '0.0', '', '_raw'), '.tif')
    )
  
  dir.create(katalog, showWarnings = FALSE, recursive = TRUE)
  
  pb = txtProgressBar(0, nrow(images), style = 3)
  for (i in seq_along(images$imageId)) {
    setTxtProgressBar(pb, i)
    download.file(images$url[i], images$file[i], mode = 'wb', quiet = TRUE, method = method)
  }
  cat("\n")
  
  return(images)
}