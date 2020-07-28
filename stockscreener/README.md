
<!-- README.md is generated from README.Rmd. Please edit that file -->

# evInvestment

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of evInvestment (Electric Vehicle but you can view any publicly
traded company) is to take a quick glance of publicly traded companies
key metrics in the following areas:

1.  Price History
2.  Distribution of Price
3.  Trade Volume History
4.  Price vs. Volume

## Installation

You can install the released version of stockscreener from [github
repo](https://github.com/ranalytica/EV_Players) with:

``` r
library(devtools)
devtools::install_github("ranalytica/simple-stock-metric")
```

## Run the package

``` r
library(stockscreener)
run_app()
```

## Acknowledgments

This package is written using **[ThinkR’s Golem
framework](https://github.com/ThinkR-open/golem)** together with several
dependecies listed in the
**[DESCRIPTION](https://github.com/ranalytica/EV_Players/blob/master/DESCRIPTION)**
to see all dependencies contained in the evInvestment.

![Shiny Site](./shiny.png) [view
website](https://ranalytica.shinyapps.io/simple_stock_metric/)
