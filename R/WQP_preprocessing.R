# pre-processing the big WQP download
library(dplyr)
library(tidyr)

fib_samps <- read.csv(here::here("WQP downloads", "biologicalresult.csv")) |>
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

write.csv(fib_reduced, here::here("WQP downloads", "biological_reduced.csv"),
          na = "",
          row.names = FALSE)
