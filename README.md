
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
#> 5965 2022-01-01  rec    def   micro 11
#> 5966 2022-01-01  rec    def   media 11
#> 5967 2022-01-01  rec    def  grande  2
#> 5968 2022-01-01  rec    def   total 24
#> 5969 2022-02-01  fal    req   micro 33
#> 5970 2022-02-01  fal    req   media 16
#> 5971 2022-02-01  fal    req  grande 13
#> 5972 2022-02-01  fal    req   total 62
#> 5973 2022-02-01  fal    dec   micro 35
#> 5974 2022-02-01  fal    dec   media 17
#> 5975 2022-02-01  fal    dec  grande  5
#> 5976 2022-02-01  fal    dec   total 57
#> 5977 2022-02-01  rec    req   micro 35
#> 5978 2022-02-01  rec    req   media 15
#> 5979 2022-02-01  rec    req  grande  5
#> 5980 2022-02-01  rec    req   total 55
#> 5981 2022-02-01  rec    def   micro 22
#> 5982 2022-02-01  rec    def   media 26
#> 5983 2022-02-01  rec    def  grande  9
#> 5984 2022-02-01  rec    def   total 57
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
