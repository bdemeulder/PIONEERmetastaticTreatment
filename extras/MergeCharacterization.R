library(Andromeda)
library(dplyr)


folderName <- '' # results folder
files <- list.files(folderName, pattern = "\\.zip$")

if (length(files) == 0) {
  stop("No study resuls found in specified path")
}

studyResults <- andromeda()
saveAndromeda(studyResults, file.path(folderName, 'results/study_results.zip'))

names <- c( "cohort", "cohort_count", "cohort_staging_count", "cohort_time_to_event", "cohort_time_to_treatment_switch",
            "covariate", "covariate_value", "database", "metrics_distribution", "treatment_sankey")
unique <- c("cohort", "covariate")

comb_res <- list()

for (table in names) {
  comb_res <- list()
  writeLines(table)
  for (file in files) {
    writeLines(paste0("DB ", file))
    andrData <- loadAndromeda(file.path(folderName, file))
    if (!table %in% names(andrData)) {
      close(andrData)
      rm(andrData)
      next
    }
    tab <- (andrData[[table]]) %>% collect()
    
    if (table == "cohort_staging_count") {
      if (!'name' %in% names(tab)) {
        warning(paste0('inconsistent ', table, ' for ', file))
        tab <- tab %>% mutate(name = cohortId)
      }
    }
    if (table == "database") {
      if (!'vocabularyVersion' %in% names(tab)) {
        warning(paste0('inconsistent ', table, ' for ', file))
        tab <- tab %>% mutate(vocabularyVersion = "")
      }
      if (!'isMetaAnalysis' %in% names(tab)) {
        warning(paste0('inconsistent ', table, ' for ', file))
        tab <- tab %>% mutate(isMetaAnalysis = "")
      }
      tab <- tab %>% select(c(databaseId, databaseName, description, vocabularyVersion, isMetaAnalysis))
      
    }
    comb_res[[file]] <- tab
    close(andrData)
    rm(andrData)
  }
  comb_res <- do.call(rbind.data.frame, comb_res)
  row.names(comb_res) <- NULL
  if (table %in% unique) {
    if ('cohortId' %in% names(comb_res)) {
      field = 'cohortId'
    } else{
      field = 'covariateId'
    }
    comb_res <- unique(comb_res) %>% arrange(!!field)
  }
  studyResults <- loadAndromeda(file.path(folderName, 'results/study_results.zip'))
  studyResults[[table]] <- comb_res
  saveAndromeda(studyResults, file.path(folderName, 'results/study_results.zip'))
}



