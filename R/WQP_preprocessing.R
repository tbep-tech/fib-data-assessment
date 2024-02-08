# pre-processing the big WQP download
library(dplyr)
library(tidyr)

fib_samps <- read.csv(here::here("data-WQP", "biologicalresult.csv")) |>
    janitor::remove_empty("cols")

fib_reduced <- fib_samps |> 
    select(SampleMedia = ActivityMediaSubdivisionName,
           SampleDate = ActivityStartDate,
           OrgID = OrganizationIdentifier,
           OrgName = OrganizationFormalName,
           Project = ProjectIdentifier,
           CollectingOrg = ActivityConductingOrganizationText,
           SampleStation = MonitoringLocationIdentifier,
           CollectionRelativeDepth = ActivityRelativeDepthName,
           Lat = ActivityLocation.LatitudeMeasure,
           Long = ActivityLocation.LongitudeMeasure,
           CharacteristicName) |> 
    filter(SampleMedia != "Groundwater",
           CharacteristicName %in% c("Fecal Coliform",
                                     "Total Coliform",
                                     "Enterococcus",
                                     "Escherichia coli"))

saveRDS(fib_reduced, file = here::here("data-WQP", "biological_reduced.rds"))

write.csv(fib_reduced, here::here("data-WQP", "biological_reduced.csv"),
          na = "",
          row.names = FALSE)
