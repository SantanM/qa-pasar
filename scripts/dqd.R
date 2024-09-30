connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = "postgresql", user = "pythonetl", 
                                                                password = "", 
                                                                server = "34.126.116.180/pasar_dev", 
                                                                port = "5432", extraSettings = "")

cdmDatabaseSchema <- "omop_pydev_schema"
resultsDatabaseSchema <- "qa_results"
cdmSourceName <- "PASAR"
numThreads <- 1
sqlOnly <- FALSE
outputFolder <- "output"
verboseMode <- TRUE
writeToTable <- FALSE
checkLevels <- c("TABLE", "FIELD", "CONCEPT")
checkNames <- c()

DataQualityDashboard::executeDqChecks(connectionDetails = connectionDetails, 
                                      cdmDatabaseSchema = cdmDatabaseSchema, 
                                      resultsDatabaseSchema = resultsDatabaseSchema,
                                      cdmSourceName = cdmSourceName, 
                                      numThreads = numThreads,
                                      sqlOnly = sqlOnly, 
                                      outputFolder = outputFolder, 
                                      verboseMode = verboseMode,
                                      writeToTable = writeToTable,
                                      checkLevels = checkLevels,
                                      checkNames = checkNames)

ParallelLogger::launchLogViewer(logFileName = file.path(outputFolder, cdmSourceName, 
                                                        sprintf("log_DqDashboard_%s.txt", cdmSourceName)))

# DataQualityDashboard::viewDqDashboard(file.path(getwd(),outputFolder, cdmSourceName, paste0("results_", cdmSourceName, ".json")))