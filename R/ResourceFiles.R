getBulkStrata <- function() {
  resourceFile <- file.path(getPathToResource(), "BulkStrata.csv")
  return(readCsv(resourceFile))
}

getCohortGroupNamesForDiagnostics <- function() {
  return(getCohortGroupsForDiagnostics()$cohortGroup)
}

getCohortGroupsForDiagnostics <- function() {
  resourceFile <- file.path(getPathToResource(), "CohortGroupsDiagnostics.csv")
  return(readCsv(resourceFile))
}

getCohortGroups <- function() {
  resourceFile <- file.path(getPathToResource(), "CohortGroups.csv")
  return(readCsv(resourceFile))
}

getCohortBasedStrata <- function() {
  resourceFile <- file.path(getPathToResource(), "CohortsToCreateStrata.csv")
  return(readCsv(resourceFile))
}

getFeatures <- function() {
  resourceFile <- file.path(getPathToResource(), "CohortsToCreateOutcome.csv")
  return(readCsv(resourceFile))
}

getFeatureTimeWindows <- function() {
  resourceFile <- file.path(getPathToResource(), "featureTimeWindows.csv")
  return(readCsv(resourceFile))
}

getTimeToEventSettings <- function(){
  resourceFile <- file.path(getPathToResource(), "TimeToEvent.csv")
  return(readCsv(resourceFile))
}

getTargetStrataXref <- function() {
  resourceFile <- file.path(getPathToResource(), "targetStrataXref.csv")
  return(readCsv(resourceFile))
}

getCohortsToCreate <- function(cohortGroups = getCohortGroups()) {
  packageName <- getThisPackageName()
  cohorts <- data.frame()
  for(i in 1:nrow(cohortGroups)) {
    c <- data.table::fread(system.file(cohortGroups$fileName[i], package = packageName, mustWork = TRUE))
    c <- c[,c('name', 'atlasName', 'atlasId', 'cohortId')]
    c$cohortType <- cohortGroups$cohortGroup[i]
    cohorts <- rbind(cohorts, c)
  }
  return(cohorts)  
}

getAllStrata <- function() {
  colNames <- c("name", "cohortId", "generationScript") # Use this to subset to the columns of interest
  bulkStrata <- getBulkStrata()
  bulkStrata <- bulkStrata[, ..colNames]
  atlasCohortStrata <- getCohortBasedStrata()
  atlasCohortStrata$generationScript <- paste0(atlasCohortStrata$cohortId, ".sql")
  atlasCohortStrata <- atlasCohortStrata[, ..colNames]
  strata <- rbind(bulkStrata, atlasCohortStrata)
  return(strata)  
}

getAllStudyCohorts <- function() {
  cohortsToCreate <- getCohortsToCreate()
  targetStrataXref <- getTargetStrataXref()
  colNames <- c("name", "cohortId")
  cohortsToCreate <- cohortsToCreate[, ..colNames]
  targetStrataXref <- targetStrataXref[, ..colNames]
  allCohorts <- rbind(cohortsToCreate, targetStrataXref)
  return(allCohorts)
}

#' @export
getAllStudyCohortsWithDetails <- function() {
  cohortsToCreate <- getCohortsToCreate()
  targetStrataXref <- getTargetStrataXref()
  allStrata <- getAllStrata()
  colNames <- c("cohortId", "cohortName", "targetCohortId", "targetCohortName", "strataCohortId", "strataCohortName", "cohortType")
  # Format - cohortsToCreate
  cohortsToCreate$targetCohortId <- cohortsToCreate$cohortId
  cohortsToCreate$targetCohortName <- cohortsToCreate$atlasName
  cohortsToCreate$strataCohortId <- 0
  cohortsToCreate$strataCohortName <- "All"
  cohortsToCreate <- dplyr::rename(cohortsToCreate, cohortName = "name")
  cohortsToCreate <- cohortsToCreate[, ..colNames]
  # Format - targetStrataXref
  stratifiedCohorts <- dplyr::inner_join(targetStrataXref, cohortsToCreate[,c("targetCohortId", "targetCohortName")], by = c("targetId" = "targetCohortId"))
  stratifiedCohorts <- dplyr::inner_join(stratifiedCohorts, allStrata[,c("cohortId", "name")], by=c("strataId" = "cohortId"))
  stratifiedCohorts <- dplyr::rename(stratifiedCohorts, targetCohortId="targetId",strataCohortId="strataId",cohortName="name.x",strataCohortName="name.y")
  stratifiedCohorts <- stratifiedCohorts[,..colNames]
  # Bind
  allCohorts <- rbind(cohortsToCreate, stratifiedCohorts)
  return(allCohorts)
}

getThisPackageVersion <- function() { 
  return(packageVersion(getThisPackageName()))
}

#' @export
getThisPackageName <- function() {
  return("PIONEERmetastaticTreatment")
}

readCsv <- function(resourceFile) {
  packageName <- getThisPackageName()
  pathToCsv <- system.file(resourceFile, package = packageName, mustWork = TRUE)
  fileContents <- data.table::fread(pathToCsv)
  return(fileContents)
}

getPathToResource <- function(useSubset = Sys.getenv("USE_SUBSET")) {
  path <- "settings"
  useSubset <- as.logical(useSubset)
  if (is.na(useSubset)) {
    useSubset = FALSE
  }
  if (useSubset) {
    path <- file.path(path, "subset/")
  }
  return(path)
}