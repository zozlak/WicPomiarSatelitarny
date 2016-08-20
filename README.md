# WicPomiarSatelitarny

Materiały do warsztatów z pomiaru satelitarnego na WIC 2016.

## Instalacja

* Ściągnij i zainstaluj:
    * R
        * dla Windows: https://cloud.r-project.org/bin/windows/base/
        * dla Maca: https://cloud.r-project.org/bin/macosx/
        * dla Linuxa: zainstauj z paczki swojej dystrybucji (typowo pakiet nazywa się *r-base*)
    * RStudio
      https://www.rstudio.com/products/rstudio/download2/ i przewiń w dół do listy *Installers for Supported Platforms*
* Uruchom *RStudio* i wykonaj kod:
    ```
    install.packages(c('devtools'))
    devtools::install_github('zozlak/WicPomiarSatelitarny')
    ```
* Pobierz repozytorium na dysk
    * Jeśli używasz GIT-a, skoluj repozytorium https://github.com/zozlak/WicPomiarSatelitarny
    * W przeciwnym wypadku ściągnij i rozpakuj plik https://github.com/zozlak/WicPomiarSatelitarny/archive/master.zip
* Zapoznaj się z zawartością katalogu _vignettes_ (czytaj więcej poniżej)
    
## Zawartość

Zasadniczo materiały znajdują się w katalogu [vignettes](https://github.com/zozlak/WicPomiarSatelitarny/tree/master/vignettes):

* [1. Pomiar satelitarny.odp](https://htmlpreview.github.io/?https://github.com/zozlak/WicPomiarSatelitarny/blob/master/vignettes/2.%20Podstawy%20REST%20API.html) - prezentacja o pomiarze satelitarnym
* [2. Podstawy REST API](https://htmlpreview.github.io/?https://github.com/zozlak/WicPomiarSatelitarny/blob/master/vignettes/2.%20Podstawy%20REST%20API.html) oraz [3. Korzystanie z REST API w R](https://htmlpreview.github.io/?https://github.com/zozlak/WicPomiarSatelitarny/blob/master/vignettes/3.%20Korzystanie%20z%20REST%20API%20w%20R.html) - handout-y opisujące korzystanie z interfejsu REST do pobierania danych satelitarnych
* [4. Zabawy z obrazami](https://htmlpreview.github.io/?https://github.com/zozlak/WicPomiarSatelitarny/blob/master/vignettes/4.%20Zabawy%20z%20obrazami.html) - handout przykładowych analiz danych satelitatnych w języku R

Od strony technicznej repozytorium jest też poprawnym pakietem R, który zawiera funkcje pomocnicze wykorzystywane w handout-ach.

## Żródło danych

Dane satelitarne wykorzystywane w handout-ach pochodzą z serwisu http://s2.boku.eodc.eu.
