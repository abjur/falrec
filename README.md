
<!-- README.md is generated from README.Rmd. Please edit that file -->

# falrec <img src='man/figures/logo.png' align="right" height="138" />

<!-- badges: start -->

[![R build
status](https://github.com/abjur/falrec/workflows/update-data/badge.svg)](https://github.com/abjur/falrec/actions)
<!-- badges: end -->

O pacote `{falrec}` baixa e atualiza os dados de falências e
recuperações disponibilizados pelo [Serasa
Experian](https://www.serasaexperian.com.br/amplie-seus-conhecimentos/indicadores-economicos).

## Base de dados

A base de dados pode ser acessada diretamente dos releases rodando a
função `falrec_data()`

``` r
library(falrec)

falrec <- falrec_data()

tail(falrec, 20)
#> # A tibble: 20 × 5
#>    data       tipo  evento tamanho     n
#>    <date>     <chr> <chr>  <chr>   <dbl>
#>  1 2023-01-01 rec   def    micro      43
#>  2 2023-01-01 rec   def    media      11
#>  3 2023-01-01 rec   def    grande     13
#>  4 2023-01-01 rec   def    total      67
#>  5 2023-02-01 fal   req    micro      50
#>  6 2023-02-01 fal   req    media      17
#>  7 2023-02-01 fal   req    grande     19
#>  8 2023-02-01 fal   req    total      86
#>  9 2023-02-01 fal   dec    micro      36
#> 10 2023-02-01 fal   dec    media      13
#> 11 2023-02-01 fal   dec    grande      6
#> 12 2023-02-01 fal   dec    total      55
#> 13 2023-02-01 rec   req    micro      59
#> 14 2023-02-01 rec   req    media      35
#> 15 2023-02-01 rec   req    grande      9
#> 16 2023-02-01 rec   req    total     103
#> 17 2023-02-01 rec   def    micro      41
#> 18 2023-02-01 rec   def    media      24
#> 19 2023-02-01 rec   def    grande      7
#> 20 2023-02-01 rec   def    total      72
```

Também é possível baixar a base diretamente do site através da função
`load_falrec()`. A princípio, essa função não é necessária, pois a base
é atualizada mensalmente.

Se quiser acessar a base em excel, ela pode ser obtida [neste
link](https://github.com/abjur/falrec/releases/download/v0.2.0/falrec.xlsx).

## Gráfico

Exemplo de gráfico usando a base de `{falrec}`:

``` r
falrec %>% 
  dplyr::mutate(wrap = dplyr::case_when(
    tipo == "fal" & evento == "req" ~ "1. Falências Requeridas",
    tipo == "fal" & evento == "dec" ~ "2. Falências Decretadas",
    tipo == "rec" & evento == "req" ~ "3. Recuperações Requeridas",
    tipo == "rec" & evento == "def" ~ "4. Recuperações Deferidas"
  )) %>% 
  dplyr::filter(n > 0) %>% 
  ggplot2::ggplot() +
  ggplot2::aes(x = data, y = n, colour = tamanho) +
  ggplot2::geom_line() +
  ggplot2::facet_wrap(~wrap, scales = "free_y", ncol = 2) +
  ggplot2::theme_bw(14) +
  ggplot2::scale_colour_viridis_d(begin = .2, end = .8) +
  ggplot2::labs(x = "Data", y = "Quantidade", colour = "Tamanho") +
  ggplot2::theme(legend.position = "bottom")
```

<img src="man/figures/README-grafico-1.png" width="100%" />

# Licença

MIT
