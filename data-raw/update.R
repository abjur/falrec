## code to prepare `falrec` dataset goes here

devtools::load_all()
falrec <- falrec::load_falrec()

saveRDS(falrec, "falrec.rds")
writexl::write_xlsx(falrec, "falrec.xlsx")

piggyback::pb_upload("falrec.rds", tag = "v0.2.0", overwrite = TRUE)
piggyback::pb_upload("falrec.xlsx", tag = "v0.2.0", overwrite = TRUE)

