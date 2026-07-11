# Replication data

This folder contains the anonymized dataset needed to reproduce the results in
**"More Information, Less Power"**.

## `dt_final.rds`

Household-by-hour analysis file used for all main results, the event study, the
engagement analysis, and the descriptive figures.

- 8,495,920 rows (892 households × hourly observations)
- One row per household and hour

### Anonymization

- The external smart-meter identifier (`meterid`) has been removed.
- The utility household identifier has been replaced by a sequential id
  (`household` = 1 … 892).

No other variables were altered, so the file reproduces the published estimates
exactly (e.g. the baseline TWFE effect of −0.4685 kWh/day).

### Key columns

| Column | Description |
|---|---|
| `household` | Anonymized household id (1–892) |
| `datetime`, `date`, `year`, `month`, `day`, `hour` | Time stamps |
| `consumption` | Hourly electricity consumption (kWh) |
| `group` | `Control` or `App` |
| `appgrp`, `controlgrp`, `tariffgrp` | Treatment-arm indicators |
| `Tranche1`, `Tranche2`, `Tranche3` | Recruitment-tranche indicators |
| `post` | Post-treatment indicator |
| `sessions`, `analysis`, `benchmark`, `game`, `bets` | App-interaction counts |
| household covariates | Dwelling, heating, appliance, and demographic variables |

## Not included

The raw 15-minute smart-meter data (~730 MB) is too large to distribute here and
is only used for two supplementary load-curve figures that are **not** part of the
paper. Those figures are skipped automatically when the file is absent. All
figures and tables in the paper are reproduced from `dt_final.rds`.
