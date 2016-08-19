#' Zapisuje dane zdjęcie do pliku jako obraz monochromatyczny, który można
#' otworzyć w zwykłej przeglądarce obrazów
#' @description
#' Większość przeglądarek obrazów obsługuje jedynie obrazy, które \itemize{ 
#' \item posiadają 1 (monochromatyczne) lub 3 (kolorowe) składowe koloru; \item
#' wszystkie składowe koloru są 8-bitowe (mają wartości całkowite od 0 do 255). 
#' }
#' 
#' Tymczasem obrazy satelitarne wykorzystują typowo bardziej precyzyjne typy
#' danych (składowa koloru opisywana 16 czy nawet 32 bitami). Powoduje to, że
#' zdjęcia satelitarne nie dają się odczytać w "zwykłych" przeglądarkach
#' obrazów.
#' 
#' Ta funkcja umożliwia zapisanie obrazu tak, by kolor opisywany był jednym
#' bajtem, dzięki czemu obraz da się otworzyć w każdej przeglądarce obrazów.
#' @details
#' Przeskalowanie wartości pikseli następuje według wzoru \code{out = round(255 
#' * (in - min) / (max - min))}. 
#' 
#' Przy tym wartości poniżej 0 i powyżej 255 zostaną przycięte do, odpowiednio,
#' 0 i 255.
#' 
#' Jeśli parametr \code{max} nie został podany, zostanie mu domyślnie przypisana
#' maksymalna wartość piksela na danym zdjęciu.
#' @param zdjecie zdjęcie do zapisania (obiekt klasy "RasterLayer")
#' @param plik ścieżka zapisu zdjęcia
#' @param min patrz sekcja "details"
#' @param max patrz sekcja "details"
#' @param paleta paleta kolorów - patrz pierwszy argument \code{\link[grDevices]{colorRamp}}
#' @return NULL
#' @export
eksportujMono = function(zdjecie, plik, min = 0, max = NA_real_, paleta = NULL){
  stopifnot(
    'RasterLayer' %in% class(zdjecie),
    is.character(plik),
    is.numeric(min),
    is.numeric(max)
  )
  
  if (is.na(max)) {
    max = max(raster::getValues(zdjecie), na.rm = TRUE)
  }
  
  zdjecie = round(255 * (zdjecie - min) / (max - min))
  zdjecie[zdjecie < 0] = 0
  zdjecie[zdjecie > 255] = 255
  
  if (!is.null(paleta)) {
    paleta = col2rgb(grDevices::colorRampPalette(paleta)(256))
    
    r = raster::setValues(zdjecie, paleta['red', raster::getValues(zdjecie) + 1])
    g = raster::setValues(zdjecie, paleta['green', raster::getValues(zdjecie) + 1])
    b = raster::setValues(zdjecie, paleta['blue', raster::getValues(zdjecie) + 1])
    eksportujKolor(r, g, b, plik, 0, 255)
  }else{
    raster::writeRaster(zdjecie, plik, overwrite = TRUE, datatype = 'INT1U')
  }
  
  return(invisible(NULL))
}