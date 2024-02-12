library(tbeptools)
library(tidyverse)

read_importfib(xlsx = here::here("data-WQP",
                                 "tbeptools_importfib_download.xlsx"),
               download_latest = FALSE)

wqp_orgs <- c("21FLDOH_WQX",
              "21FLHILL_WQX",
              "21FLMANA_WQX",
              "21FLPASC_WQX",
              "21FLPDEM_WQX",
              "21FLPOLK_WQX")  # may want to compare these to *only* these providers from the website download

wqp_fibs <- purrr::map(wqp_orgs,
                       ~ read_importwqp(org = .x, type = "fib"))

wqp_fibs2 <- wqp_fibs |> 
    set_names(wqp_orgs) |> 
    map(~ {
        names(.x)[1] <- "Station"
        .x
    }) |> 
    list_rbind(names_to = "OrgID")

saveRDS(wqp_fibs2, file = here::here("data-WQP",
                                     "tbeptools_importwqp.rds"))

