## code to prepare `falrec` dataset goes here

falrec <- falrec::load_falrec()
writexl::write_xlsx("inst/extdata/falrec.xlsx")
usethis::use_data(falrec, overwrite = TRUE)
