###############################################################################
# 06_make_replication_data.R
#
# Purpose:
# Build the anonymized replication dataset shipped with the public repository.
#
# It takes the full processed analysis file (dt_final.rds), removes the
# external meter identifier, replaces the utility household id with a
# sequential id (1..N), and saves a compressed copy under data/replication/.
#
# This script is run once by the authors (FULL MODE, with access to the
# restricted processed data). Replication users do NOT need to run it - they
# use the data/replication/dt_final.rds that ships with the repository.
###############################################################################

source(here::here("R", "00_setup.R"))

library(data.table)

repl_dir <- here::here("data", "replication")
dir.create(repl_dir, showWarnings = FALSE, recursive = TRUE)

message("Loading full processed analysis data...")
dt <- readRDS(here::here("data", "processed", "dt_final.rds"))
setDT(dt)

# --- 1. Drop the external meter identifier ----------------------------------
if ("meterid" %in% names(dt)) dt[, meterid := NULL]

# --- 2. Replace the utility household id with a sequential id ----------------
set.seed(123456)
old_ids <- sort(unique(dt$household))
crosswalk <- data.table(
  household = old_ids,
  household_new = seq_along(old_ids)
)
dt <- crosswalk[dt, on = "household"]
dt[, household := household_new]
dt[, household_new := NULL]

# --- 3. Save the anonymized replication data --------------------------------
out_file <- file.path(repl_dir, "dt_final.rds")
saveRDS(dt, out_file, compress = "xz")

size_mb <- file.info(out_file)$size / 1048576
message(sprintf("Wrote %s (%.1f MB, %d households, %d rows).",
                out_file, size_mb, uniqueN(dt$household), nrow(dt)))
