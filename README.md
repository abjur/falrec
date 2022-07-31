
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
#> 6013 2022-04-01  rec    def   micro 37
#> 6014 2022-04-01  rec    def   media 17
#> 6015 2022-04-01  rec    def  grande  8
#> 6016 2022-04-01  rec    def   total 62
#> 6017 2022-05-01  fal    req   micro 49
#> 6018 2022-05-01  fal    req   media 18
#> 6019 2022-05-01  fal    req  grande  8
#> 6020 2022-05-01  fal    req   total 75
#> 6021 2022-05-01  fal    dec   micro 49
#> 6022 2022-05-01  fal    dec   media 16
#> 6023 2022-05-01  fal    dec  grande  2
#> 6024 2022-05-01  fal    dec   total 67
#> 6025 2022-05-01  rec    req   micro 36
#> 6026 2022-05-01  rec    req   media 16
#> 6027 2022-05-01  rec    req  grande  6
#> 6028 2022-05-01  rec    req   total 58
#> 6029 2022-05-01  rec    def   micro 31
#> 6030 2022-05-01  rec    def   media 19
#> 6031 2022-05-01  rec    def  grande  6
#> 6032 2022-05-01  rec    def   total 56
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
