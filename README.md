
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
#> 5981 2022-02-01  rec    def   micro 22
#> 5982 2022-02-01  rec    def   media 26
#> 5983 2022-02-01  rec    def  grande  9
#> 5984 2022-02-01  rec    def   total 57
#> 5985 2022-03-01  fal    req   micro 37
#> 5986 2022-03-01  fal    req   media 13
#> 5987 2022-03-01  fal    req  grande 19
#> 5988 2022-03-01  fal    req   total 69
#> 5989 2022-03-01  fal    dec   micro 38
#> 5990 2022-03-01  fal    dec   media 17
#> 5991 2022-03-01  fal    dec  grande  4
#> 5992 2022-03-01  fal    dec   total 59
#> 5993 2022-03-01  rec    req   micro 59
#> 5994 2022-03-01  rec    req   media 22
#> 5995 2022-03-01  rec    req  grande  7
#> 5996 2022-03-01  rec    req   total 88
#> 5997 2022-03-01  rec    def   micro 46
#> 5998 2022-03-01  rec    def   media 19
#> 5999 2022-03-01  rec    def  grande  5
#> 6000 2022-03-01  rec    def   total 70
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
