## code to prepare `falrec` dataset goes here

devtools::load_all()
falrec <- falrec::load_falrec()
dir.create("inst/extdata", FALSE, TRUE)
writexl::write_xlsx(falrec, "inst/extdata/falrec.xlsx")
usethis::use_data(falrec, overwrite = TRUE)
devtools::document()
devtools::install_local()
