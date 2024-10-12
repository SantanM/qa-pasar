connectionDetails <- DatabaseConnector::createConnectionDetails(
    dbms = "postgresql", user = "sqletl", 
    password = "", 
    server = "34.126.116.180/pasar_dev", 
    port = "5432", extraSettings = "", 
    pathToDriver = '../'
)

cdmDatabaseSchema <- "omop_sqldev_schema"
resultsDatabaseSchema <- "qa_results"
cdmSourceName <- "PASAR"
numThreads <- 1
sqlOnly <- FALSE
outputFolder <- "../output"
verboseMode <- TRUE
writeToTable <- FALSE
checkLevels <- c("TABLE", "FIELD", "CONCEPT")
checkNames <- c()
cdmVersion <- "5.4"

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
                                      checkNames = checkNames, 
                                      cdmVersion = cdmVersion)