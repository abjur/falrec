
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

A base de dados pode ser acessada diretamente rodando

``` r
library(falrec)

tail(falrec, 20)
#>            data tipo evento tamanho  n
#> 5949 2021-12-01  rec    def   micro 59
#> 5950 2021-12-01  rec    def   media 12
#> 5951 2021-12-01  rec    def  grande  4
#> 5952 2021-12-01  rec    def   total 75
#> 5953 2022-01-01  fal    req   micro 27
#> 5954 2022-01-01  fal    req   media  8
#> 5955 2022-01-01  fal    req  grande 11
#> 5956 2022-01-01  fal    req   total 46
#> 5957 2022-01-01  fal    dec   micro 30
#> 5958 2022-01-01  fal    dec   media 12
#> 5959 2022-01-01  fal    dec  grande  3
#> 5960 2022-01-01  fal    dec   total 45
#> 5961 2022-01-01  rec    req   micro 31
#> 5962 2022-01-01  rec    req   media 30
#> 5963 2022-01-01  rec    req  grande  6
#> 5964 2022-01-01  rec    req   total 67
#> 5965 2022-01-01  rec    def   micro 11
#> 5966 2022-01-01  rec    def   media 11
#> 5967 2022-01-01  rec    def  grande  2
#> 5968 2022-01-01  rec    def   total 24
```

Também é possível baixar a base diretamente do site através da função
`load_falrec()`. A princípio, essa função não é necessária, pois a base
é atualizada mensalmente.

Se quiser acessar a base em excel, ela pode ser obtida [neste
link](https://github.com/abjur/falrec/blob/master/inst/extdata/falrec.xlsx?raw=true).

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
