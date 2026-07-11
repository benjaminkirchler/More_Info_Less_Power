###############################################################################
# 00_setup.R
# Purpose: Environment setup + path definition + raw data validation
###############################################################################

rm(list = ls())
gc()
message("Running 00_setup.R ...")

# ---------------------------------------------------------------------------
# 1. Required packages (fail if missing)
# ---------------------------------------------------------------------------
required_packages <- c(
  "tidyverse",
  "data.table",
  "lubridate",
  "R.utils",
  "haven",
  "fixest",
  "MatchIt",
  "tableone",
  "stargazer",
  "outliers",
  "estimatr",
  "interactions",
  "janitor",
  "here",
  "readxl",
  "wesanderson",
  "broom"
)

missing_packages <- required_packages[!required_packages %in% rownames(installed.packages())]

if (length(missing_packages) > 0) {
  stop(paste0(
    "Missing required packages: ",
    paste(missing_packages, collapse = ", "),
    "\nPlease install them manually before running the replication."
  ))
}

invisible(lapply(required_packages, library, character.only = TRUE))

# ---------------------------------------------------------------------------
# 2. Global options
# ---------------------------------------------------------------------------
options(
  scipen = 999,
  digits = 4
)

set.seed(123456)

# English date labels in figures regardless of system locale
invisible(tryCatch(
  Sys.setlocale("LC_TIME", "English"),
  warning = function(w) Sys.setlocale("LC_TIME", "en_US.UTF-8"),
  error   = function(e) Sys.setlocale("LC_TIME", "en_US.UTF-8")
))

# ---------------------------------------------------------------------------
# 3. Project paths
# ---------------------------------------------------------------------------
paths <- list(
  data_raw       = here::here("data", "raw"),
  data_processed = here::here("data", "processed"),
  output_tables  = here::here("paper", "tables"),
  output_figures = here::here("paper", "figures"),
  output_models  = here::here("output", "models")
)

# Create folders if they do not exist
dir.create(paths$data_processed, showWarnings = FALSE, recursive = TRUE)
dir.create(paths$output_tables, showWarnings = FALSE, recursive = TRUE)
dir.create(paths$output_figures, showWarnings = FALSE, recursive = TRUE)
dir.create(paths$output_models, showWarnings = FALSE, recursive = TRUE)

# ---------------------------------------------------------------------------
# 3b. Replication mode
# If the full processed data is unavailable but the anonymized replication
# data (shipped with the public repository) is present, use it instead.
# ---------------------------------------------------------------------------
if (!file.exists(file.path(paths$data_processed, "dt_analysis.rds")) &&
    file.exists(here::here("data", "replication", "dt_analysis.rds"))) {
  paths$data_processed <- here::here("data", "replication")
  message("Full processed data not found - using anonymized replication data in data/replication/.")
}

# ---------------------------------------------------------------------------
# 4. Raw data availability (needed only for pipeline stages 01-03)
# ---------------------------------------------------------------------------
required_files <- c(
  file.path(paths$data_raw, "PA_cleaned.csv"),
  file.path(paths$data_raw, "MILP_app_usage.xlsx")
)

has_raw_data <- all(file.exists(required_files))

if (!has_raw_data) {
  message(
    "Raw data not available (restricted; see README). ",
    "Pipeline stages 01-03 will be skipped; the analysis runs from the ",
    "included replication data."
  )
}

message("00_setup.R completed successfully.")