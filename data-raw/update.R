## code to prepare `falrec` dataset goes here

falrec <- falrec::load_falrec()
usethis::use_data(falrec, overwrite = TRUE)
