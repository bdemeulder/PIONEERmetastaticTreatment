PIONEER metastatic Hormone-Sensitive Prostate Cancer treatment characterization
=============

<img src="https://img.shields.io/badge/Study%20Status-Results%20Available-yellow.svg" alt="Study Status: Results Available">

- Analytics use case(s): **Characterization**
- Study type: **Clinical Application**
- Tags: **cancer**
- Study lead: **Juan-Gomez Rivas**
- Study lead forums tag: **[bdemeulder](https://forums.ohdsi.org/u/bdemeulder)**
- Study start date: **October 31, 2022**
- Study end date: **-**
- Protocol: **In press, submitted version is available in this repository: https://github.com/bdemeulder/PIONEERmetastaticTreatment/blob/master/PIONEER%20Studyathon%202%20protocol.pdf**
- Publications: **-**
- Results explorer: **[Shiny App: Characterization study](https://pioneer-shiny.hzdr.de/app/PioneerMetastaticTreatmentExplorer/)**

The aim of this study is to characterize the metastatic Hormone-Sensitive Prostate Cancer (mHSPC) patients and their treatment plans. The impact of choice of medications on the clinical outcomes (progression, death) will be assessed.

This study is undertaken by the 2022 prostate cancer studyathon of the [IMI PIONEER](https://prostate-pioneer.eu) project.

### FAQ
#### *What do I need to do to run the package?*
OHDSI study repos are designed to have information in the README.md (where you are now) to provide you with instructions on how to navigate the repo. This package has two major components:
1. [CohortDiagnostics](http://www.github.com/ohdsi/cohortDiagnostics) - an OHDSI R package used to perform diagnostics around the fitness of use of the study phenotypes on your CDM. By running this package you will allow study leads to understand: cohort inclusion rule attrition, inspect source code lists for a phenotype, find orphan codes that should be in a particular concept set but are not, compute incidnece across calendar years, age and gender, break down index events into specific concepts that triggered then, compute overlap of two cohorts and compute basic characteristics of selected cohorts. This package will be requested of all sites. It is run on all available data not just your prostate cancer populations. This allows us to understand how the study phenotypes perform in your database and identify any potential gaps in the phenotype definitions.
2. RunStudy - the characterization package to evaluate Target-Stratum-Feature pairings computing cohort characteristics and creating tables/visualizations to summarize differences between groups.

#### *I have a problem running the code or want to contribute a fix or enhancement.*
Please review the questions below, and if that doesn't answer it consider filing an issue in the Github tracker for the project: https://github.com/ohdsi-studies/PioneerWatchfulWaiting/issues

#### *I don't understand the organization of this Github Repo.*
The study repo has the following major pieces:
- `R` folder = the folder which will provide the R library the scripts it needs to execute this study
- `documents` folder = the folder where you will find study documents (protocols, 1-sliders to explain the study, etc)
- `extras` folder = the folder where we store a copy of the instructions (called `CodeToRun.R`) below and other files that the study needs to do things like package maintenance or talk with the Shiny app. Aside from `CodeToRun.R`, you can largely ignore the rest of these files.
- `inst` folder = This is the "install" folder. It contains the most important parts of the study: the study cohort JSONs (analogous to what ATLAS shows you in the Export tab), the study settings, a sub-folder that contains information to the Shiny app, and the study cohort SQL scripts that [SqlRender](https://cran.r-project.org/web/packages/SqlRender/index.html) will use to translate these into your RDBMS.

Below you will find instructions for how to bring this package into your `R`/ `RStudio` environment. Note that if you are not able to connect to the internet in `R`/ `RStudio` to download pacakges, you will have to pull the [TAR file](https://github.com/ohdsi-studies/PioneerWatchfulWaiting/archive/master.zip). 

#### *I see you've got a reference `Renviron` but I've never used that? What do I do?*
You can install a package like `usethis` to quickly access your Renviron file.  `usethis` :package: has a useful helper function to modify `.Renviron`:

`usethis::edit_r_environ()` will open your user .Renviron which is in your home

`usethis::edit_r_environ("project")` will open the one in your project

Your Renviron file will pop-up through these commands. It will give you the opportunity to edit it as the directions instruct. If you need more help, consider reviewing this [R Community Resource](https://rviews.rstudio.com/2017/04/19/r-for-enterprise-understanding-r-s-startup/).

#### *What should I do if I get an error when I run the package?*
If you have any issues running the package, please report bugs / roadblocks via [GitHub Issues](https://github.com/bdemeulder/PIONEERmetastaticTreatment/issues) on this repo. Where possible, we ask you share error logs and snippets of warning messages that come up in your `R` console. You may also attach screenshots. Please include the RDMBS (aka your SQL dialect) you work on. If possible, run `traceback()` in your `R` and paste this into your error as well. The study leads will triage these errors with you.

#### *What should I do when I finish?*
If you finish running a study package and upload results to the SFTP, please post a message in the *Data sources and study execution* channel in Teams to notify you have dropped results in the folder. If your upload is unsucessful, please add the results to Teams directly.

## Package Requirements
- A database in [Common Data Model version 5](https://github.com/OHDSI/CommonDataModel) in one of these platforms: SQL Server, Oracle, PostgreSQL, IBM Netezza, Apache Impala, Amazon RedShift, or Microsoft APS.
- R version 4.0.0 or newer
- On Windows: [RTools](http://cran.r-project.org/bin/windows/Rtools/)
- [Java](http://java.com)
- Suggested: 25 GB of free disk space

See [this video](https://youtu.be/DjVgbBGK4jM) for instructions on how to set up the R environment on Windows.

## How to Run the Study
1. In `R`, you will build an `.Renviron` file. An `.Renviron` is an R environment file that sets variables you will be using in your code. It is encouraged to store these inside your environment so that you can protect sensitive information. Below are brief instructions on how to do this:

````
# The code below makes use of R environment variables (denoted by "Sys.getenv(<setting>)") to 
# allow for protection of sensitive information. If you'd like to use R environment variables stored
# in an external file, this can be done by creating an .Renviron file in the root of the folder
# where you have cloned this code. For more information on setting environment variables please refer to: 
# https://stat.ethz.ch/R-manual/R-devel/library/base/html/readRenviron.html
#
# Below is an example .Renviron file's contents: (please remove)
# the "#" below as these too are interprted as comments in the .Renviron file:
#
#    DBMS = "postgresql"
#    DB_SERVER = "database.server.com"
#    DB_PORT = 5432
#    DB_USER = "database_user_name_goes_here"
#    DB_PASSWORD = "your_secret_password"
#    FFTEMP_DIR = "E:/fftemp"
#    USE_SUBSET = FALSE
#    CDM_SCHEMA = "your_cdm_schema"
#    COHORT_SCHEMA = "public"  # or other schema to write intermediate results to
#    PATH_TO_DRIVER = "/path/to/jdbc_driver"
#
# The following describes the settings
#    DBMS, DB_SERVER, DB_PORT, DB_USER, DB_PASSWORD := These are the details used to connect
#    to your database server. For more information on how these are set, please refer to:
#    http://ohdsi.github.io/DatabaseConnector/
#
#    FFTEMP_DIR = A directory where temporary files used by the FF package are stored while running.
#
#    USE_SUBSET = TRUE/FALSE. When set to TRUE, this will allow for runnning this package with a 
#    subset of the cohorts/features. This is used for testing. PLEASE NOTE: This is only enabled
#    by setting this environment variable.
#
# Once you have established an .Renviron file, you must restart your R session for R to pick up these new
# variables. 
````

2. To install the study package (which will build a new R library for you that is specifically for `PIONEERmetastaticTreatment`), type the following into a new `R` script and run. You can also retrieve this code from `extras/CodeToRun.R`.

````
# Prevents errors due to packages being built for other R versions: 
Sys.setenv("R_REMOTES_NO_ERRORS_FROM_WARNINGS" = TRUE)
# 
# First, it probably is best to make sure you are up-to-date on all existing packages.
# Important: This code is best run in R, not RStudio, as RStudio may have some libraries
# (like 'rlang') in use.
#update.packages(ask = "graphics")

# When asked to update packages, select '1' ('update all') (could be multiple times)
# When asked whether to install from source, select 'No' (could be multiple times)
#install.packages("devtools")
#devtools::install_github("bdemeulder/PIONEERmetastaticTreatment")
````
In [`CodeToRun.R`](extras/CodeToRun.R) you will find a function `verifyDependencies()` which you can use to verify that all dependencies installed correctly.

*Note: When using this installation method it can be difficult to 'retrace' because you will not see the same folders that you see in the GitHub Repo. If you would prefer to have more visibility into the study contents, you may alternatively download the [TAR file](https://github.com/ohdsi-studies/PioneerWatchfulWaiting/archive/master.zip) for this repo and bring this into your `R`/`RStudio` environment. An example of how to call ZIP files into your `R` environment can be found in the [The Book of OHDSI](https://ohdsi.github.io/TheBookOfOhdsi/PopulationLevelEstimation.html#running-the-study-package).*

*Note: if you run into the error `LoadLibrary failure: %1 is not a valid Win32 application` when compiling rJava dependencies, try this instead: *devtools::install_github("bdemeulder/PIONEERmetastaticTreatment",INSTALL_opts = "--no-multiarch").*

*Note: If you are using the `DatabaseConnector` package for the first time, then you may also need to download the JDBC drivers to your database. See the [package documentation](https://ohdsi.github.io/DatabaseConnector/reference/jdbcDrivers.html), you can do this with a command like `DatabaseConnector::downloadJdbcDrivers(dbms="redshift", pathToDriver="/my-home-folder/jdbcdrivers")`.*

*Note: if you run into 403 errors from Github URLs when installing the package, you may have exceeded your Github API rate limit. If you have a Github account, then you can create a personal access token (PAT) using the link https://github.com/settings/tokens/new?scopes=repo,gist&description=R:GITHUB_PAT, and add that to your local environment, for example using `credentials::set_github_pat()` (install the package with `install.packages("credentials")` if you don't have it). The counter should also reset after an hour, so alternatively you can wait for that to happen.*

3. Great work! Now you have set-up your environment and installed the library that will run the package. You can use the following `R` script to load in your library and configure your environment connection details:

```
library(PIONEERmetastaticTreatment)

# Optional: specify where the temporary files (used by the ff package) will be created:
fftempdir <- if (Sys.getenv("FFTEMP_DIR") == "") "~/fftemp" else Sys.getenv("FFTEMP_DIR")
options(fftempdir = fftempdir)

# Details for connecting to the server:
dbms = Sys.getenv("DBMS")
user <- if (Sys.getenv("DB_USER") == "") NULL else Sys.getenv("DB_USER")
password <- if (Sys.getenv("DB_PASSWORD") == "") NULL else Sys.getenv("DB_PASSWORD")
# password <- Sys.getenv("DB_PASSWORD")
server = Sys.getenv("DB_SERVER")
port = Sys.getenv("DB_PORT")
extraSettings <- if (Sys.getenv("DB_EXTRA_SETTINGS") == "") NULL else Sys.getenv("DB_EXTRA_SETTINGS")
pathToDriver <- if (Sys.getenv("PATH_TO_DRIVER") == "") NULL else Sys.getenv("PATH_TO_DRIVER")
connectionString <- if (Sys.getenv("CONNECTION_STRING") == "") NULL else Sys.getenv("CONNECTION_STRING")

connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = dbms,
                                                                user = user,
                                                                password = password,
                                                                server = server,
                                                                port = port,
                                                                connectionString = connectionString,
                                                                pathToDriver = pathToDriver)



# For Oracle: define a schema that can be used to emulate temp tables:
oracleTempSchema <- NULL
````
4. You will first need to run the `CohortDiagnostics` package on your entire database. This package is used as a diagnostic to provide transparency into the concept prevalence in your database as it relates to the concept sets and phenotypes we've prepared for the Target, Stratum and Features included in this analysis. We encourage sites to share this information so that we can help design better studies that capture the nuance of your local care delivery and coding practices.

````
# Run cohort diagnostics -----------------------------------
runCohortDiagnostics(connectionDetails = connectionDetails,
                     cdmDatabaseSchema = cdmDatabaseSchema,
                     cohortDatabaseSchema = cohortDatabaseSchema,
                     cohortStagingTable = cohortStagingTable,
                     oracleTempSchema = oracleTempSchema,
                     cohortIdsToExcludeFromExecution = cohortIdsToExcludeFromExecution,
                     exportFolder = outputFolder,
                     # cohortGroupNames = c("target", "outcome", "strata"), # Optional - will use all groups by default
                     databaseId = databaseId,
                     databaseName = databaseName,
                     databaseDescription = databaseDescription,
                     minCellCount = minCellCount)
````

this package may take some time to run. This is normal. Allow at least 3 hours for this step. Package runtime will vary based on your infrastructure. We appreciate your patience!

When the package is completed, you can view the `CohortDiagnostics` output in a local Shiny viewer:
````
# Use the next command to review cohort diagnostics and replace "target" with
# one of these options: "target", "outcome", "strata"
# CohortDiagnostics::launchDiagnosticsExplorer(file.path(outputFolder, "diagnostics", "target"))
````

5. Once you have run `CohortDiagnostics` you are encouraged to reach out to the study leads to review your outputs through the Teams channel. 

6. You can now run the characterization package. This step is designed to take advantage of incremental building. This means if the job fails, the R package will start back up where it left off. This package has been designed to be computationally efficient. Package runtime will vary based on your infrastructure but it should be significantly faster than your prior CohortDiagnostic run.

In your `R` script, you will use the following code:
````
# Use this to run the study. The results will be stored in a zip file called 
# 'Results_<databaseId>.zip in the outputFolder. 
 runStudy(connectionDetails = connectionDetails,
          cdmDatabaseSchema = cdmDatabaseSchema,
          cohortDatabaseSchema = cohortDatabaseSchema,
          cohortStagingTable = cohortStagingTable,
          cohortTable = cohortTable,
          featureSummaryTable = featureSummaryTable,
          oracleTempSchema = cohortDatabaseSchema,
          exportFolder = outputFolder,
          databaseId = databaseId,
          databaseName = databaseName,
          databaseDescription = databaseDescription,
          #cohortGroups = c("target"), # Optional - will use all groups by default
          cohortIdsToExcludeFromExecution = cohortIdsToExcludeFromExecution,
          cohortIdsToExcludeFromResultsExport = cohortIdsToExcludeFromResultsExport,
          incremental = TRUE,
          useBulkCharacterization = useBulkCharacterization,
          minCellCount = minCellCount)
  ````

7. You can now look at the characterization output in a local Shiny application:
````
preMergeResultsFiles(outputFolder)
launchShinyApp(outputFolder)
````
