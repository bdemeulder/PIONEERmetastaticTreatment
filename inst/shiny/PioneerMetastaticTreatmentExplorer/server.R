library(shiny)
library(shinydashboard)
library(magrittr)
library(htmltools)
library(data.table)
source("PlotsAndTables.R")
source("utilities.R")
source("survplot_core.R")
source("ggsurvtable.R")


truncateStringDef <- function(columns, maxChars) {
  list(
    targets = columns,
    render = JS(sprintf("function(data, type, row, meta) {\n
      return type === 'display' && data != null && data.length > %s ?\n
        '<span title=\"' + data + '\">' + data.substr(0, %s) + '...</span>' : data;\n
     }", maxChars, maxChars))
  )
}

minCellCountDef <- function(columns) {
  list(
    targets = columns,
    render = JS("function(data, type) {
    if (type !== 'display' || isNaN(parseFloat(data))) return data;
    if (data >= 0) return data.toString().replace(/(\\d)(?=(\\d{3})+(?!\\d))/g, '$1,');
    return '<' + Math.abs(data).toString().replace(/(\\d)(?=(\\d{3})+(?!\\d))/g, '$1,');
  }")
  )
}

minCellPercentDef <- function(columns) {
  list(
    targets = columns,
    render = JS("function(data, type) {
    if (type !== 'display' || isNaN(parseFloat(data))) return data;
    if (data >= 0) return (100 * data).toFixed(1).replace(/(\\d)(?=(\\d{3})+(?!\\d))/g, '$1,') + '%';
    return '<' + Math.abs(100 * data).toFixed(1).replace(/(\\d)(?=(\\d{3})+(?!\\d))/g, '$1,') + '%';
  }")
  )
}

minCellRealDef <- function(columns, digits = 1) {
  list(
    targets = columns,
    render = JS(sprintf("function(data, type) {
    if (type !== 'display' || isNaN(parseFloat(data))) return data;
    if (data >= 0) return data.toFixed(%s).replace(/(\\d)(?=(\\d{3})+(?!\\d))/g, '$1,');
    return '<' + Math.abs(data).toFixed(%s).replace(/(\\d)(?=(\\d{3})+(?!\\d))/g, '$1,');
  }", digits, digits))
  )
}

styleAbsColorBar <- function(maxValue, colorPositive, colorNegative, angle = 90) {
  JS(sprintf("isNaN(parseFloat(value))? '' : 'linear-gradient(%fdeg, transparent ' + (%f - Math.abs(value))/%f * 100 + '%%, ' + (value > 0 ? '%s ' : '%s ') + (%f - Math.abs(value))/%f * 100 + '%%)'", 
             angle, maxValue, maxValue, colorPositive, colorNegative, maxValue, maxValue))
}

getDataTableSettings <- function() {
  dtSettings <- list(
    options = list(pageLength = 25,
                   lengthMenu = c(25, 50, 100, -1),
                   searching = TRUE,
                   lengthChange = TRUE,
                   ordering = TRUE,
                   paging = TRUE,
                   info = TRUE,
                   scrollX = TRUE),
    extensions = list() #list('Buttons') #'RowGroup'
  )
                     
  return(dtSettings)
}

renderBorderTag <-  function() {
  return(htmltools::withTags(
    div(class = "cohort-heading")
  ))
}

showTermsOfUseModal <- function() {
  showModal(
    modalDialog(
      title = "Terms of Use", 
      includeMarkdown("md/terms_of_use.md"),
      footer = tagList(
        actionButton("termsOfUseReject", "Reject", style = "color: white", class="btn-danger"),
        actionButton("termsOfUseAccept", "Accept", style = "color: white", class="btn-success")
      )
    )
  )
}

TERMS_OF_USE_ACCEPTED <- "accepted"

shinyServer(function(input, output, session) {
  # Terms Of Use Modal -------------------
  observe({
    # Show this modal whenever the user has not accepted the terms of use
    if (!is.null(input$jscookie)) {
      if (input$jscookie != TERMS_OF_USE_ACCEPTED) {
        showTermsOfUseModal()
      }
    }
  })
  
  # Used for testing cookie set/removal
  # observeEvent(input$cookieGetVal, {
  #   if (!is.null(input$jscookie)) {
  #     writeLines(input$jscookie)
  #   } else {
  #     writeLines("NULL")
  #   }
  # })
  # 
  # observeEvent(input$cookieRmVal, {
  #   writeLines("Cookie removed")
  #   session$sendCustomMessage("rmCookie", "")
  #   writeLines("----------------")
  # })
  
  observeEvent(input$termsOfUseReject, {
    session$sendCustomMessage("alert", "You must accept the terms of use to use the application.")
  })
  
  observeEvent(input$termsOfUseAccept, {
    writeLines("Set cookie")
    session$sendCustomMessage("setCookie", TERMS_OF_USE_ACCEPTED)
    removeModal()
  })
  
  
  # Filter Options -----
  cohortIdTimeToEvent <- reactive({
    unlist(cohortXref[cohortXref$targetId %in% targetCohortIdTimeToEvent() & 
                      cohortXref$strataName %in% input$strataTimeToEvent,c("cohortId")]
           )
  })
  
  targetCohortIdTimeToEvent <- reactive({
    targetCohort$targetId[targetCohort$targetName %in% input$targetTimeToEvent]
  })
  
  cohortIdTreatmentPatterns <- reactive({
    unlist(cohortXref[cohortXref$targetId %in% targetCohortIdTreatmentPatterns() &
                        cohortXref$strataName %in% input$strataTreatmentPatterns,c("cohortId")]
    )
  })

  targetCohortIdTreatmentPatterns <- reactive({
    targetCohort$targetId[targetCohort$targetName %in% input$targetTreatmentPatterns]
  })

  cohortIdMetricsDistribution <- reactive({
    unlist(cohortXref[cohortXref$targetId %in% targetCohortIdMetricsDistribution() &
                      cohortXref$strataName %in% input$strataMetricsDistribution, "cohortId"])
  })
  
  targetCohortIdMetricsDistribution <- reactive({
    targetCohort$targetId[targetCohort$targetName %in% input$targetMetricsDistribution]
  })
  
  cohortIdList <- reactive({
    unlist(cohortXref[cohortXref$targetId %in% targetCohortIdList() & 
                      cohortXref$strataName %in% input$strataCohortList, "cohortId"]
           )
  })
  
  targetCohortIdList <- reactive({
    targetCohort$targetId[targetCohort$targetName %in% input$targetCohortList]
  })
  
  targetCohortName <- reactive({
    cohort <- cohortXref[cohortXref$cohortId == cohortId(), c("targetName", "strataId", "strataName")]
    fullCohortName <- cohort$targetName[1]
    if (cohort$strataId[1] > 0) {
      fullCohortName <- paste(fullCohortName, cohort$strataName[1])
    }
    return(fullCohortName)
  })
  
  comparatorCohortName <- reactive({
    cohort <- cohortXref[cohortXref$cohortId == comparatorCohortId(), c("targetName", "strataId", "strataName")]
    fullCohortName <- cohort$targetName[1]
    if (cohort$strataId[1] > 0) {
      fullCohortName <- paste(fullCohortName, cohort$strataName[1])
    }
    return(fullCohortName)
  })
  
  cohortId <- reactive({
    unlist(cohortXref[cohortXref$targetId == targetId() &
                      cohortXref$strataName == input$strataCohort, "cohortId"])[[1]]
  })
  
  targetId <- reactive({
    targetCohort$targetId[targetCohort$targetName == input$targetCohort]
  })

  comparatorCohortId <- reactive({
    unlist(cohortXref[cohortXref$targetId == comparatorTargetId() & 
                      cohortXref$strataName == input$comparatorStrataCohort, "cohortId"])[[1]]
  })
  
  comparatorTargetId <- reactive({
    targetCohort$targetId[targetCohort$targetName == input$comparatorCohort]
  })
  
  windowId <- reactive({
    timeWindow[timeWindow$name %in% input$timeWindowFilter,c("windowId")]
  })
  
  covariateAnalysisId <- reactive({
    domain[domain$name %in% input$domainFilter,c("covariateAnalysisId")]
  })
  
  output$cohortName <- renderUI({ 
    htmltools::withTags(
      div(h4(targetCohortName()))
    )
  })
  
  output$comparisonName <- renderUI({
    targetCount <- andrData$cohort_count %>% 
      dplyr::filter(cohortId == !!cohortId(), databaseId == !!input$database) %>%
      dplyr::pull('cohortSubjects')
    comparatorCount <- andrData$cohort_count %>% 
      dplyr::filter(cohortId == !!comparatorCohortId(), databaseId == !!input$database) %>%
      dplyr::pull('cohortSubjects')
    
    htmltools::withTags(
      div(h4("Target: ", targetCohortName(), " (n=", targetCount, ")"),
          h4("Comparator: ", comparatorCohortName(), " (n=", comparatorCount, ")"))
    )
  })
  
  # Cohort Info ---------
  output$borderCohortInfo <- renderUI({ renderBorderTag() })
  
  getCohortInfoTable <- reactive({
    data <- cohortInfo
    atlasCohortUrl <- "https://pioneer.hzdr.de/atlas/#/cohortdefinition/"
    githubCohortUrl <- "https://github.com/bdemeulder/PIONEERmetastaticTreatment/tree/master/inst/sql/sql_server/"
    data$url <- ifelse(data$circeDef == TRUE, 
                       paste0(atlasCohortUrl, data$atlasId),
                       paste0(githubCohortUrl, data$cohortId, ".sql"))
    data <- data[, c("name", "url")]
    return(data)
  })
  
  output$cohortInfoTable <- renderDataTable({
    table <- getCohortInfoTable()
    table$url <- paste0("<a href='", table$url, "' target='_blank'>", table$url, "</a>")
    sketch <- htmltools::withTags(table(
      class = 'display',
      thead(
        tr(
          th('Cohort Name'),
          th('Definition')
        )
      )
    ))
    
    options = list(pageLength = 25,
                   searching = TRUE,
                   lengthChange = TRUE,
                   ordering = TRUE,
                   paging = TRUE,
                   info = TRUE,
                   scrollX = TRUE
    )
    dataTable <- datatable(table,
                           options = options,
                           rownames = FALSE,
                           container = sketch, 
                           escape = FALSE,
                           class = "stripe nowrap compact")
    return(dataTable)
    
  })
  
  output$dlCohortInfo <- downloadHandler('cohort_info.csv', content = function(file) {
    table <- getCohortInfoTable()
    write.csv(table, file, row.names = FALSE, na = "")
  })
  
  
  
  
  # timeToEvent-----------------
  output$survivalHeader <- renderText({
    paste(input$targetTimeToEvent, input$strataTimeToEvent, sep = " ")
  })
  
  output$dlTimeToEvent <- downloadHandler(
    filename = function() {
      "timeToEvent.csv"
    },
    content = function(file) {
      target_id <- andrData$cohort_count %>%
        dplyr::filter(databaseId %in% !!input$databasesTimeToEvent, cohortId %in% !!cohortIdTimeToEvent()) %>% 
        dplyr::pull(cohortId)
      targetIdTimeToEventData <- andrData$cohort_time_to_event %>%
        dplyr::filter(targetId == target_id, databaseId == !!input$databasesTimeToEvent) %>% 
        dplyr::collect()
      write.csv(targetIdTimeToEventData, file, row.names = FALSE, na = "")
    }
  )
  
  output$TimeToEventPlot <- renderPlot({
    target_id <- andrData$cohort_count %>%
      dplyr::filter(databaseId %in% !!input$databasesTimeToEvent, cohortId %in% !!cohortIdTimeToEvent()) %>% 
      dplyr::pull(cohortId)

    if (length(target_id) == 0 | is.null(input$KMPlot)) { return(ggplot2::ggplot()) }
    
    events <- KMIds %>%
      dplyr::filter(name %in% !!input$KMPlot) %>%
      dplyr::pull(eventId)

    targetIdTimeToEventData <- andrData$cohort_time_to_event %>%
      dplyr::filter(targetId == target_id,
                    databaseId == !!input$databasesTimeToEvent,
                    eventId %in% events) %>%
      dplyr::collect() %>%
      dplyr::inner_join(KMIds, by = 'eventId') %>%
      dplyr::rename(strata = name) %>%
      dplyr::arrange(strata, time) %>% 
      dplyr::select(time, surv, n.risk, n.censor, n.event, upper, lower, strata)
    targetIdTimeToEventData <- as.data.frame(targetIdTimeToEventData) 

    color_map <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
    names(color_map) <- sort(KMIds$name)

    plot <- ggsurvplot_core(
      targetIdTimeToEventData,
      risk.table = "nrisk_cumcensor",
      palette = color_map,
      legend.labs = sort(input$KMPlot),
      cmap = color_map,
      conf.int = TRUE,
      legend.title = 'Event',
      ylim = c(min(targetIdTimeToEventData$lower), 1),
      ggtheme = ggplot2::theme_bw()
      )
    return(plot)
  })
  
  
  # Metrics Distribution
  output$metricsHeader <- renderText({
    paste(input$targetMetricsDistribution, input$strataMetricsDistribution, sep=" ")
  })
  
  
  getMetricsTable <- reactive ({
    target_id <- andrData$cohort_count %>% 
      dplyr::filter(databaseId %in% !!input$databasesMetricsDistribution, 
                    cohortId %in% !!cohortIdMetricsDistribution()) %>% 
      dplyr::pull(cohortId)
    
    metricsTable <- andrData$metrics_distribution %>%
      dplyr::filter(cohortDefinitionId == target_id, databaseId == !!input$databasesMetricsDistribution) %>% 
      dplyr::collect()
    names(metricsTable)[names(metricsTable) == 'iqr'] <- 'IQR'
    return(metricsTable[,c('analysisName', 'IQR', 'minimum', 'q1', 'median', 'q3', 'maximum')])
  })
  
  
  output$metricsTable <- renderDataTable(
    getMetricsTable()
  )
  
  
  # Cohort Counts ---------
  output$borderCohortCounts <- renderUI({ renderBorderTag() })
  
  getCohortCountsTable <- reactive({
    data <- andrData$cohort_count %>% 
      dplyr::filter(databaseId %in% !!input$databases, cohortId %in% !! cohortIdList()) %>% 
      dplyr::collect()
    table <- dplyr::inner_join(cohortXref, data, by = "cohortId")
    table[order(table$targetName),]
  })
  
  getCohortCountsTablePivotedByDB <- reactive({
    columnsToInclude <- c("cohortId","targetId","targetName","strataId","strataName","cohortType", "cohortSubjects")
    subjectIndex <-  match("cohortSubjects", columnsToInclude)
    data <- getCohortCountsTable()
    databaseIds <- unique(data$databaseId)
    databaseIds <- sort(databaseIds)
    table <- data[data$databaseId == databaseIds[1], ..columnsToInclude]
    colnames(table)[subjectIndex] <- paste(colnames(table)[2], databaseIds[1], sep = "_")
    if (length(databaseIds) > 1) {
      for (i in 2:length(databaseIds)) {
        temp <- data[data$databaseId == databaseIds[i], ..columnsToInclude]
        colnames(temp)[subjectIndex] <- paste(colnames(temp)[subjectIndex], databaseIds[i], sep = "_")
        table <- merge(table, temp, all = TRUE)
      }
    }
    return(list(table = table, databaseIds = databaseIds))
  })

  output$cohortCountsTable <- renderDataTable({
    cohortCountsByDB <- getCohortCountsTablePivotedByDB()
    databaseIds <- cohortCountsByDB$databaseIds
    table <- cohortCountsByDB$table
    table$cohortId <- NULL
    table$targetId <- NULL
    table$strataId <- NULL
    table$cohortType <- NULL

    sketch <- htmltools::withTags(table(
      class = 'display',
      thead(
        tr(
          th(rowspan = 2, 'Cohort'),
          th(rowspan = 2, 'Strata'),
          lapply(databaseIds, th, colspan = 1, class = "dt-center")
        ),
        tr(
          lapply(rep(c("Subjects"), length(databaseIds)), th)
        )
      )
    ))

    sortCallback <- c(
      "var dt = table.table().node();",
      "$(dt).on('order.dt', function(e, ctx, order) {",
      "console.log(order);",
      " if (Array.isArray(order) && order.length > 0) {",
      "    console.log(order[0]);",
      "    col = order[0].col;",
      "    if (col < 2) {",
      "      var api = new $.fn.DataTable.Api(this);",
      "      var orderingArr = [];",
      "      for (var i=0 ; i<order.length ; i++) {",
      "        orderingArr.push(order[i].col);",
      "      }",
      #"      api.rowGroup().dataSrc(orderingArr);",
      "    }",
      "  }",
      "})"
    )
    columnDefs = list(
      #list(targets = c(0), visible = 0),
      minCellCountDef(2:(length(databaseIds) + 1))
    )
    dtSettings <- getDataTableSettings();
    dtSettings$options <- append(dtSettings$options, list(columnDefs = columnDefs))

    dataTable <- datatable(table,
                           # callback = JS(sortCallback),
                           rownames = FALSE,
                           container = sketch,
                           escape = FALSE,
                           options = dtSettings$options,
                           extensions = dtSettings$extensions,
                           class = "stripe nowrap compact")
    return(dataTable)
  })

  output$dlCohortCountsByDb <- downloadHandler(
    filename = function() {
      'cohort_counts_by_db.csv'
    },
    content = function(file) {
      table <- getCohortCountsTablePivotedByDB()$table
      write.csv(table, file, row.names = FALSE, na = "")
    }
  )

  output$dlCohortCountsFlat <- downloadHandler(
    filename = function() {
      'cohort_counts.csv'
    },
    content = function(file) {
      table <- getCohortCountsTable()
      write.csv(table, file, row.names = FALSE, na = "")
    }
  )

  # Cohort Characterization -------
  output$borderCharacterization <- renderUI({ renderBorderTag() })
  getCharacterizationTable <- reactive({
    covariateDataSubset <- andrData$covariate_value %>% 
      dplyr::filter(cohortId == !!cohortId(), databaseId %in% !!input$databases) %>% 
      dplyr::collect() 
    covariateFiltered <- getFilteredCovariates()
    table <- merge.data.table(as.data.table(covariateFiltered), as.data.table(covariateDataSubset))
    table$cohortName <- targetCohortName()
    return(table[,c("cohortId","cohortName","covariateId","covariateName","covariateAnalysisId","windowId","databaseId","mean")])
  })
  
  getCharacterizationTablePivotedByDB <- reactive({
    columnsToInclude <- c("cohortId","cohortName","covariateId","covariateName","covariateAnalysisId","windowId","mean")
    meanColumnIndex <-  match("mean", columnsToInclude)
    data <- getCharacterizationTable()
    counts <- andrData$cohort_count %>%
      dplyr::filter(cohortId == !!cohortId(), databaseId %in% !!input$databases) %>%
      dplyr::collect()
    databaseIds <- unique(data$databaseId)
    databaseIdsWithCounts <- merge(databaseIds, counts, by.x = "x", by.y = "databaseId")
    databaseIdsWithCounts <- dplyr::rename(databaseIdsWithCounts, databaseId = "x")
    table <- data[data$databaseId == databaseIdsWithCounts$databaseId[1], ..columnsToInclude]
    colnames(table)[meanColumnIndex] <- paste(colnames(table)[meanColumnIndex], databaseIdsWithCounts$databaseId[1], sep = "_")
    if (nrow(databaseIdsWithCounts) > 1) {
      for (i in 2:nrow(databaseIdsWithCounts)) {
        temp <- data[data$databaseId == databaseIdsWithCounts$databaseId[i], ..columnsToInclude]
        colnames(temp)[meanColumnIndex] <- paste(colnames(temp)[meanColumnIndex], databaseIdsWithCounts$databaseId[i], sep = "_")
        table <- merge.data.table(table, temp, by = columnsToInclude[-length(columnsToInclude)], all = TRUE)
      }
    }
    table <- table[order(table$covariateName), ]
    return(list(table = table, databaseIdsWithCounts = databaseIdsWithCounts))
  })
  
  output$characterizationTable <- renderDataTable({
    characterizationByDB <- getCharacterizationTablePivotedByDB()
    databaseIdsWithCounts <- characterizationByDB$databaseIdsWithCounts
    table <- characterizationByDB$table
    
    columnDefs <- list(
      truncateStringDef(0, 150),
      minCellPercentDef(1:nrow(databaseIdsWithCounts))
    )
    table$cohortId <- NULL
    table$cohortName <- NULL
    table$covariateId <- NULL
    table$covariateAnalysisId <- NULL
    table$windowId <- NULL
    dtSettings <- getDataTableSettings();
    dtSettings$options <- append(dtSettings$options, list(columnDefs = columnDefs))
    sketch <- htmltools::withTags(table(
      class = 'display',
      thead(
        tr(
          th(rowspan = 3, 'Covariate Name'),
          lapply(databaseIdsWithCounts$databaseId, th, colspan = 1, class = "dt-center no-border no-padding")
        ),
        tr(
          lapply(paste0("(n = ", format(databaseIdsWithCounts$cohortSubjects, big.mark = ","), ")"), th, colspan = 1, class = "dt-center no-padding")
        ),
        tr(
          lapply(paste0(databaseIdsWithCounts$databaseId, "_pct"), th, colspan = 1)
        )
      )
    ))
    table <- datatable(table,
                       rownames = FALSE,
                       container = sketch,
                       escape = FALSE,
                       options = dtSettings$options,
                       extensions = dtSettings$extensions,
                       class = "stripe nowrap compact")
    table <- formatStyle(table = table,
                         columns = 1:nrow(databaseIdsWithCounts)+1,
                         background = styleColorBar(c(0,1), "lightblue"),
                         backgroundSize = "98% 88%",
                         backgroundRepeat = "no-repeat",
                         backgroundPosition = "center")
    return(table)
  })
  
  output$dlCharacterizationByDb <- downloadHandler(
    filename = function() {
      "characterization_by_db.csv"
    },
    content = function(file) {
      table <- getCharacterizationTablePivotedByDB()$table
      write.csv(table, file, row.names = FALSE, na = "")
    }
  )
  
  output$dlCharacterizationFlat <- downloadHandler(
    filename = function() {
      "characterization.csv"
    },
    content = function(file) {
      table <- getCharacterizationTable()
      write.csv(table, file, row.names = FALSE, na = "")
    }
  )
  
  # Cohort Comparison --------------
  output$borderCharCompare <- renderUI({ renderBorderTag() })
  
  computeBalance <- reactive({
    if (cohortId() == comparatorCohortId()) { data.table() }
    
    covariateFiltered <- getFilteredCovariates()
    covs1 <- andrData$covariate_value %>%
      dplyr::filter(cohortId == !!cohortId(), databaseId %in% !!input$database) %>%
      dplyr::collect()
    covs2 <- andrData$covariate_value %>%
      dplyr::filter(cohortId == !!comparatorCohortId(), databaseId %in% !!input$database) %>%
      dplyr::collect()
    covs1 <- merge(covs1, covariateFiltered)
    covs2 <- merge(covs2, covariateFiltered)
    balance <- compareCohortCharacteristics(covs1, covs2)
    if (nrow(balance == 0 )) { data.table() }
    balance$absStdDiff <- abs(balance$stdDiff)
    # Rename columns
    colnames(balance) <- c("covariateId","covariateName","covariateAnalysisId","windowId","targetMean","targetSD","comparatorMean","comparatorSD","sd","stdDiff","absStdDiff")
    balance$targetCohortId <- cohortId()
    balance$targetCohortName <- targetCohortName()
    balance$comparatorCohortId <- comparatorCohortId()
    balance$comparatorCohortName <- comparatorCohortName()
    balance$databaseId <- input$database
    balance <- balance[order(balance$covariateName),]
    return(balance)
  })
  
  output$charCompareTable <- renderDataTable({
    balance <- computeBalance()
    if (nrow(balance) == 0) {
      return(NULL)
    }
    
    table <- balance[, c("covariateName", "targetMean", "targetSD", "comparatorMean", "comparatorSD", "stdDiff")]
    colnames(table) <- c("Covariate name", "Mean Target", "SD Target", "Mean Comparator", "SD Comparator", "StdDiff")
    columnDefs <- list(
      truncateStringDef(0, 150),
      minCellPercentDef(c(1,3)),
      minCellRealDef(c(2,4), 2)
    )
    dtSettings <- getDataTableSettings();
    dtSettings$options <- append(dtSettings$options, list(columnDefs = columnDefs))
    table <- datatable(table,
                       rownames = FALSE,
                       escape = FALSE,
                       options = dtSettings$options,
                       extensions = dtSettings$extensions,
                       class = "stripe nowrap compact")
    table <- formatStyle(table = table,
                         columns = c(2,4),
                         background = styleColorBar(c(0,1), "lightblue"),
                         backgroundSize = "98% 88%",
                         backgroundRepeat = "no-repeat",
                         backgroundPosition = "center")
    table <- formatStyle(table = table,
                         columns = 6,
                         background = styleAbsColorBar(1, "lightblue", "pink"),
                         backgroundSize = "98% 88%",
                         backgroundRepeat = "no-repeat",
                         backgroundPosition = "center")
    table <- formatRound(table, c(3, 5, 6), digits = 2)
    return(table)
  })
  
  output$charComparePlot <- renderPlot({
    balance <- computeBalance()
    if (nrow(balance) == 0) {
      return(NULL)
    }
    balance$targetMean[is.na(balance$targetMean)] <- 0
    balance$comparatorMean[is.na(balance$comparatorMean)] <- 0
    plot <- ggplot2::ggplot(balance, ggplot2::aes(x = targetMean, y = comparatorMean, color = absStdDiff)) +
      ggplot2::geom_point(alpha = 0.3, shape = 16, size = 2) +
      ggplot2::geom_abline(slope = 1, intercept = 0, linetype = "dashed") +
      ggplot2::geom_hline(yintercept = 0) +
      ggplot2::geom_vline(xintercept = 0) +             
      ggplot2::scale_x_continuous("Mean Target", limits = c(0, 1)) +
      ggplot2::scale_y_continuous("Mean Comparator", limits = c(0, 1)) +
      ggplot2::scale_color_gradient("Absolute\nStd. Diff.", low = "blue", high = "red", space = "Lab", na.value = "red")
    return(plot)
  }, res = 100)
  
  output$hoverInfoCharComparePlot <- renderUI({
    balance <- computeBalance()
    balance$targetMean[is.na(balance$targetMean)] <- 0
    balance$comparatorMean[is.na(balance$comparatorMean)] <- 0
    if (nrow(balance) == 0) {
      return(NULL)
    } else {
      hover <- input$plotHoverCharCompare
      point <- nearPoints(balance, hover, threshold = 5, maxpoints = 1, addDist = TRUE)
      if (nrow(point) == 0) {
        return(NULL)
      }
      text <- paste(point$covariateName, 
                    "",
                    sprintf("<b>Mean Target: </b> %0.2f", point$targetMean),
                    sprintf("<b>Mean Comparator: </b> %0.2f", point$comparatorMean), 
                    sprintf("<b>Std diff.: </b> %0.2f", point$stdDiff), 
                    sep = "<br/>")
      left_px <- hover$coords_css$x
      top_px <- hover$coords_css$y
      if (hover$x > 0.5) {
        xOffset <- -505
      } else {
        xOffset <- 5
      }
      style <- paste0("position:absolute; z-index:100; background-color: rgba(245, 245, 245, 0.85); ",
                      "left:",
                      left_px + xOffset,
                      "px; top:",
                      top_px - 150,
                      "px; width:500px;")
      div(
        style = "position: relative; width: 0; height: 0",
        wellPanel(
          style = style,
          p(HTML(text))
        )
      )
    }
  }) 
  
  output$dlCharCompare <- downloadHandler(
    filename = function() {
      "characterization_compare.csv"
    },
    content = function(file) {
      table <- computeBalance()
      table <- table[,c("targetCohortId","targetCohortName","comparatorCohortId","comparatorCohortName","covariateId","covariateName","covariateAnalysisId","windowId","databaseId","targetMean","targetSD","comparatorMean","comparatorSD","stdDiff")]
      write.csv(table, file, row.names = FALSE, na = "")
    }
  )
  

    # Treatment Patterns ---------------------
  output$treatmentPatternsHeader <- renderText({
    paste(input$targetTreatmentPatterns, input$strataTreatmentPatterns, sep = " ")
  })
  
  
  sankeyData <- reactive({
    target_id <- andrData$cohort_count %>%
      dplyr::filter(databaseId %in% !!input$databasesTreatmentPatterns, cohortId %in% !!cohortIdTreatmentPatterns()) %>%
      dplyr::pull(cohortId)
    
    if (length(target_id) == 0) {
      count <- 0
    }
    else{
      count <- andrData$cohort_count %>% dplyr::filter(cohortId == target_id) %>% dplyr::pull(cohortEntries)
    }
    
    if (count > 30) {
      sankeyData <- andrData$treatment_sankey %>%
        dplyr::filter(cohortId == target_id, databaseId == !!input$databasesTreatmentPatterns) %>%
        dplyr::collect()
      
      to_filter <- sankeyData %>% dplyr::group_by(sourceName) %>% dplyr::summarise(val = sum(value)) %>% dplyr::filter(val > 30)
      
      sankeyData <- sankeyData %>% dplyr::filter(sourceName %in% to_filter$sourceName)
      return(sankeyData)
    }
    return(data.frame())
  })
  
  # Sankey
  sendSankeyData <- function(){
    data <- sankeyData()
    jsonData <- jsonlite::toJSON(data, pretty = TRUE)
    session$sendCustomMessage(type = "jsondata", jsonData)
  }

  
  observeEvent(input$databasesTreatmentPatterns, {
    sendSankeyData()
  })

  observeEvent(input$targetTreatmentPatterns, {
    sendSankeyData()
  })

  observeEvent(input$strataTreatmentPatterns, {
    sendSankeyData()
  })
  
  
  #Sankey Table
  output$dlSankeyData <- downloadHandler(
    filename = function() {
      paste0(paste(input$targetTreatmentPatterns, input$strataTreatmentPatterns, sep = " "), "_Sankey.csv")
    },
    content = function(file) {
      dlSankeyData <- sankeyData() %>% 
        dplyr::select(sourceName, targetName, value) %>% 
        dplyr::arrange(sourceName, desc(value))
      write.csv(dlSankeyData, file)
    }
  )
  
  output$sankeyTable <- renderDataTable({
    data <- sankeyData()
    if(nrow(data > 30)){
      DT::datatable(
        data %>% 
          dplyr::select(sourceName, targetName, value) %>% 
          dplyr::arrange(sourceName, desc(value)),
        options = list(pageLength = 25))
    }
    else(
      DT::datatable(data)
    )
  })
  
  
  #KM
  output$timeToTreatmentSwitchPlot <- renderPlot({
    target_id <- andrData$cohort_count %>%
      dplyr::filter(databaseId %in% !!input$databasesTreatmentPatterns, cohortId %in% !!cohortIdTreatmentPatterns()) %>%
      dplyr::pull(cohortId)
    
    if (length(target_id) == 0 | is.null(input$KMPlot)) { ggplot2::ggplot() }

    targetIdTimeToTreatmentSwitchData <- andrData$cohort_time_to_treatment_switch %>% 
      dplyr::filter(targetId == target_id, databaseId == !!input$databasesTreatmentPatterns) %>%
      dplyr::collect()

    targetIdTimeToTreatmentSwitchData <- targetIdTimeToTreatmentSwitchData %>%
      dplyr::select(time, surv, n.censor, n.event, n.risk, upper, lower) 
    targetIdTimeToTreatmentSwitchData$strata <- 'Time To Treatment Switch'
    
    color_map = c(' ' = "#838383")
    ggsurvplot_core(targetIdTimeToTreatmentSwitchData,
                    risk.table = "nrisk_cumcensor",
                    palette = color_map,
                    legend.labs = ' ',
                    cmap = color_map,
                    conf.int = TRUE,
                    legend.title = ' ',
                    ylim = c(min(targetIdTimeToTreatmentSwitchData$lower), 1),
                    ggtheme = ggplot2::theme_bw()
                    )
  })
  

  # Database Info ------------------
  output$borderDatabaseInformation <- renderUI({ renderBorderTag() })
  
  output$databaseInformationTable <- renderDataTable({
    table <- database[, c("databaseId", "databaseName", "description", "termsOfUse")]
    options = list(pageLength = 25,
                   searching = TRUE,
                   lengthChange = FALSE,
                   ordering = TRUE,
                   paging = FALSE,
                   columnDefs = list(list(width = '10%', targets = 0),
                                     list(width = '20%', targets = 1),
                                     list(width = '35%', targets = 2))
    )
    table <- datatable(table,
                       options = options,
                       colnames = c("ID", "Name", "Description", "Terms of Use"),
                       rownames = FALSE,
                       class = "stripe compact")
    return(table)
  })
  
  output$dlDatabaseInformation <- downloadHandler(
    filename = function() {
      "database_info.csv"
    },
    content = function(file) {
      table <- database[, c("databaseId", "databaseName", "description")]
      write.csv(table, file, row.names = FALSE, na = "")
    }
  )
  
  
  showInfoBox <- function(title, htmlFileName) {
    showModal(modalDialog(
      title = title,
      easyClose = TRUE,
      footer = NULL,
      size = "l",
      HTML(readChar(htmlFileName, file.info(htmlFileName)$size) )
    ))
  }
  
  # Info boxes -------
  observeEvent(input$cohortCountsInfo, {
    showInfoBox("Cohort Counts", "html/cohortCounts.html")
  })
  
  observeEvent(input$cohortCharacterizationInfo, {
    showInfoBox("Cohort Characterization", "html/cohortCharacterization.html")
  })
  
  observeEvent(input$compareCohortCharacterizationInfo, {
    showInfoBox("Compare Cohort Characteristics", "html/compareCohortCharacterization.html")
  })
  
  observeEvent(input$dlCohortCountsInfo, {
    showInfoBox("Download", "html/download.html")
  })
  
  observeEvent(input$dlCharacterizationInfo, {
    showInfoBox("Download", "html/download.html")
  })

  # Helper functions ------
  getFilteredCovariates <- function() {
    covariate %>% 
      dplyr::filter(windowId %in% windowId()$windowId, covariateAnalysisId %in% covariateAnalysisId()$covariateAnalysisId) 
  }
})
