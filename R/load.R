#' Load falrec data
#'
#' @export
load_falrec <- function() {

  u <- paste0(
    "https://www.serasaexperian.com.br/",
    "conteudos/indicadores-economicos/"
  )
  r <- httr::GET(u)
  xp <- paste0(
    "//a[contains(@data-gtm-subname, 'decretadas') and @download]"
  )
  u_falrec <- r %>%
    xml2::read_html() %>%
    xml2::xml_find_all(xp) %>%
    xml2::xml_attr("href")
  f <- tempfile(fileext = ".xls")
  httr::GET(u_falrec, httr::write_disk(f, TRUE))
  tamanhos <- c("micro", "media", "grande", "total")
  colunas <- c(
    "data",
    paste0("fal_req_", tamanhos),
    paste0("fal_dec_", tamanhos),
    paste0("rec_req_", tamanhos),
    paste0("rec_def_", tamanhos),
    paste0("remove_", 1:3)
  )

  da_falrec <- readxl::read_excel(f, skip = 5, col_names = colunas)
  da_falrec <- da_falrec[, !grepl("remove", colunas)]
  da_falrec[["data"]] <- as.Date(da_falrec[["data"]])
  da_falrec <- da_falrec %>%
    tidyr::pivot_longer(-1, "variavel", values_to = "n") %>%
    tidyr::separate("variavel", c("tipo", "evento", "tamanho"))

  file.remove(f)

  da_falrec
}
