# More Information, Less Power

Replication package for the paper **"More Information, Less Power: Field
Experimental Evidence on the Effect of Information Provision on Residential
Electricity Consumption."**

The paper studies the causal effect of a smartphone electricity-feedback
application on household electricity consumption using a randomized field
experiment with a staggered rollout in Upper Austria.

---

## 1. Quick start (replication)

Requirements: **R ≥ 4.4** and the packages listed in `R/00_setup.R`.

```r
# From the repository root, in R or RStudio:
source("masterfile.R")
```

`masterfile.R` reproduces all figures and tables in the paper from the
anonymized data shipped in [`data/replication/`](data/replication/). Figures are
written to `paper/figures/`, tables and intermediate CSVs to `paper/tables/`.

No raw data or extra downloads are needed for this.

---

## 2. Two run modes

The pipeline detects automatically (in `R/00_setup.R`) which data is available:

| Mode | Trigger | What runs |
|---|---|---|
| **Replication** (default, public) | full processed data absent | analysis + figures/tables from `data/replication/dt_final.rds` |
| **Full** (authors) | restricted raw data present in `data/raw/` | raw → clean → prepare → analysis |

In replication mode, two supplementary 15-minute load-curve figures (not part of
the paper) are skipped, because the underlying 15-minute data is too large to
distribute.

---

## 3. Repository structure

```
├── masterfile.R              # Runs the full pipeline (both modes)
├── R/
│   ├── 00_setup.R            # Packages, paths, mode detection, locale
│   ├── 01_load_data.R        # Full mode: load raw data
│   ├── 02_cleaning.R         # Full mode: cleaning
│   ├── 03_prepare_descriptives.R
│   ├── 04.1_analysis_pre.R   # Full mode: builds dt_final.rds
│   ├── 04.02_descriptives.R  # Descriptives, balance, compliance, engagement
│   ├── 04.03_analysis.R      # Main results: TWFE + Sun–Abraham, event study
│   ├── 05_engagement_analysis.R
│   └── 06_make_replication_data.R  # Authors only: builds the anonymized file
├── data/
│   ├── raw/                  # Restricted (not distributed)
│   ├── processed/            # Full processed data (not distributed)
│   └── replication/          # Anonymized data shipped with the repo
├── paper/                    # LaTeX source, figures, tables
│   ├── main.tex
│   ├── sections/
│   ├── figures/
│   └── tables/
└── README.md
```

---

## 4. Which script makes which paper exhibit

| Paper exhibit | Produced by |
|---|---|
| Fig. 1 (salience theory), Figs. 2–3 (app screenshots) | static images in `paper/figures/` |
| Fig. 4 (pre-treatment load curve) | `R/04.02_descriptives.R` |
| Fig. 5 (app engagement over time) | `R/04.02_descriptives.R` |
| Fig. 6 (event study) | `R/04.03_analysis.R` |
| Fig. 7 (pre-treatment by tranche) | `R/04.02_descriptives.R` |
| Table 1 (recruitment), Table 2 (balance) | `R/04.02_descriptives.R` |
| Table 3 (main results), Table 8 (event study) | `R/04.03_analysis.R` |
| Table 4 (effects by engagement) | `R/05_engagement_analysis.R` |
| Appendix tables (sample construction, engagement) | `R/04.02_descriptives.R` |

Regression tables in the paper are hand-set in LaTeX from the R console output.

---

## 5. Data availability

The household-level smart-meter and app-usage data were collected in cooperation
with an Upper Austrian utility and are governed by a data-sharing agreement. The
anonymized analysis file required to reproduce the paper is provided in
`data/replication/` (see the note there). The raw data can be made available on
reasonable request, subject to the agreement.

---

## 6. Funding

This project has received funding from the European Union's Horizon 2020 research
and innovation programme under grant agreement No. 695945.
