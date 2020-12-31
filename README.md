
<!-- README.md is generated from README.Rmd. Please edit that file -->

# falrec

<!-- badges: start -->
<!-- badges: end -->

O pacote `{falrec}` baixa e atualiza os dados de falências e
recuperações disponibilizados pelo [Serasa
Experian](https://www.serasaexperian.com.br/amplie-seus-conhecimentos/indicadores-economicos).

## Base de dados

A base de dados pode ser acessada diretamente rodando

``` r
library(falrec)

head(falrec, 20)
#>          data tipo evento tamanho   n
#> 1  1991-01-01  fal    req   micro   0
#> 2  1991-01-01  fal    req   media   0
#> 3  1991-01-01  fal    req  grande   0
#> 4  1991-01-01  fal    req   total 724
#> 5  1991-01-01  fal    dec   micro   0
#> 6  1991-01-01  fal    dec   media   0
#> 7  1991-01-01  fal    dec  grande   0
#> 8  1991-01-01  fal    dec   total  49
#> 9  1991-01-01  rec    req   micro   0
#> 10 1991-01-01  rec    req   media   0
#> 11 1991-01-01  rec    req  grande   0
#> 12 1991-01-01  rec    req   total   0
#> 13 1991-01-01  rec    def   micro   0
#> 14 1991-01-01  rec    def   media   0
#> 15 1991-01-01  rec    def  grande   0
#> 16 1991-01-01  rec    def   total   0
#> 17 1991-02-01  fal    req   micro   0
#> 18 1991-02-01  fal    req   media   0
#> 19 1991-02-01  fal    req  grande   0
#> 20 1991-02-01  fal    req   total 645
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
