#' Zapisuje dane 3 zdjęcia do pliku jako obraz kolorowy, który można otworzyć w
#' zwykłej przeglądarce obrazów
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
#' Ta funkcja umożliwia zapisanie obrazu tak, by każda składowa koloru opisywana
#' była jednym bajtem, dzięki czemu obraz da się otworzyć w każdej przeglądarce
#' obrazów.
#' @details
#' Przeskalowanie wartości pikseli następuje według wzoru \code{out = round(255 
#' * (in - min) / (max - min))}. 
#' 
#' Przy tym wartości poniżej 0 i powyżej 255 zostaną przycięte do, odpowiednio,
#' 0 i 255.
#' 
#' Jeśli parametr \code{max} nie został podany, zostanie mu domyślnie przypisana
#' maksymalna wartość piksela spośród wszystkich zdjęć wejściowych.
#' @param zdjecieR zdjęcie do wykorzystania jako czerwona składowa koloru
#'   (obiekt klasy "RasterLayer")
#' @param zdjecieG zdjęcie do wykorzystania jako zielona składowa koloru (obiekt
#'   klasy "RasterLayer")
#' @param zdjecieB zdjęcie do wykorzystania jako niebieska składowa koloru
#'   (obiekt klasy "RasterLayer")
#' @param plik ścieżka zapisu zdjęcia
#' @param min patrz sekcja "details"
#' @param max patrz sekcja "details"
#' @return NULL
#' @export
eksportujKolor = function(zdjecieR, zdjecieG, zdjecieB, plik, min = 0, max = NA_real_){
  stopifnot(
    'RasterLayer' %in% class(zdjecieR),
    'RasterLayer' %in% class(zdjecieG),
    'RasterLayer' %in% class(zdjecieB),
    is.character(plik),
    is.numeric(min),
    is.numeric(max)
  )
  
  if (is.na(max)) {
    max = max(
      max(raster::getValues(zdjecieR), na.rm = TRUE),
      max(raster::getValues(zdjecieG), na.rm = TRUE),
      max(raster::getValues(zdjecieB), na.rm = TRUE),
      na.rm = TRUE
    )
  }
  
  skladowe = list(zdjecieR, zdjecieG, zdjecieB)
  skladowe = lapply(skladowe, function(x){
    x = round(255 * (x - min) / (max - min))
    x[x < 0] = 0
    x[x > 255] = 255
    return(x)
  })
  
  raster::writeRaster(stack(skladowe), plik, overwrite = TRUE, datatype = 'INT1U')
  
  return(invisible(NULL))
}