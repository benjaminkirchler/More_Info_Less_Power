###############################################################################
# masterfile.R
#
# Reproduces all figures and tables in the paper
# "More Information, Less Power".
#
# The pipeline runs in one of two modes, detected automatically in
# R/00_setup.R depending on which data is present:
#
#   FULL MODE  (raw data available; restricted, see README)
#     raw data -> load -> clean -> prepare -> analysis-ready data -> analysis
#
#   REPLICATION MODE (public repository)
#     runs from the anonymized analysis data shipped in data/replication/
#     and reproduces every figure and table reported in the paper.
#     Two supplementary 15-minute load-curve figures that are NOT part of
#     the paper are skipped automatically, because the underlying 15-minute
#     data is too large to distribute on GitHub.
#
# Usage:
#   source("masterfile.R")
###############################################################################

message("Starting masterfile...")

source("R/00_setup.R")   # defines paths, has_raw_data, and replication mode

# --- Stage 1: raw data -> analysis-ready data (FULL MODE only) --------------
if (has_raw_data) {
  source("R/01_load_data.R")
  source("R/02_cleaning.R")
  source("R/03_prepare_descriptives.R")
  source("R/04.1_analysis_pre.R")   # builds dt_final.rds from dt_analysis.rds
} else {
  message("Raw data not found - running in replication mode from data/replication/.")
}

# --- Stage 2: analysis, figures, and tables ---------------------------------
# (runs from dt_final.rds, which is either rebuilt above or shipped in
#  data/replication/)
source("R/04.02_descriptives.R")     # descriptives, balance, compliance, engagement
source("R/04.03_analysis.R")         # main results: TWFE + Sun-Abraham, event study
source("R/05_engagement_analysis.R") # treatment effects by engagement level

message("Masterfile finished successfully.")
