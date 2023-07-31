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
    "//a[contains(@data-gtm-subname, 'recuperacoes') and @download]"
  )
  u_falrec <- r %>%
    xml2::read_html() %>%
    xml2::xml_find_all(xp) %>%
    xml2::xml_attr("href")
  f <- tempfile(fileext = ".xlsx")
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

  # unzip <- unzip(f, exdir = here::here('data-raw'))
  path <- f

  da_falrec <- readxl::read_excel(path, skip = 5, col_names = colunas)
  da_falrec <- da_falrec[, !grepl("remove", colunas)]
  da_falrec[["data"]] <- as.Date(da_falrec[["data"]])
  da_falrec <- da_falrec %>%
    tidyr::pivot_longer(
      fal_req_micro:rec_def_total, names_to = "variavel", values_to = "n"
    ) %>%
    tidyr::separate("variavel", c("tipo", "evento", "tamanho"))
  da_falrec <- da_falrec[!is.na(da_falrec$n), ]

  file.remove(f)

  da_falrec
}

#' Load falrec data from release
#'
#' @export
falrec_data <- function() {
  path <- tempfile()
  dir.create(path, FALSE, TRUE)
  file_rds <- "falrec.rds"
  piggyback::pb_download(file = file_rds, repo = "abjur/falrec", dest = path)
  f <- file.path(path, file_rds)
  res <- readRDS(f)
  unlink(path, recursive = TRUE)
  res
}
