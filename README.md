# Liver Survival Analysis Using Kaplan-Meier and Cox Proportional Hazards Model

## Project Overview

This project is a final project for Survival Analysis that applies statistical survival modeling to analyze time-to-event data from a public liver dataset. The analysis focuses on estimating survival probabilities, comparing survival curves across patient characteristics, and identifying factors associated with survival time using the Cox Proportional Hazards model.

The project demonstrates the use of Kaplan-Meier survival curves, log-rank tests, Cox regression, proportional hazards assumption checking, and stratified Cox modeling.

---

## Objectives

The objectives of this project are:

1. To estimate overall survival probability using the Kaplan-Meier method.
2. To compare survival probabilities across patient groups based on age, BMI, weight, and height.
3. To perform log-rank tests to assess differences between survival curves.
4. To build a Cox Proportional Hazards model using patient characteristics.
5. To evaluate the proportional hazards assumption using diagnostic tests and log-log plots.
6. To apply a stratified Cox model when the proportional hazards assumption is not fully satisfied.

---

## Dataset

The dataset used in this project is a public liver survival dataset.

### Main Variables

| Variable | Description |
|---|---|
| `id` | Patient ID |
| `age` | Patient age |
| `gender` / `male` | Patient gender indicator |
| `weight` | Patient weight |
| `height` | Patient height |
| `bmi` | Body Mass Index |
| `futime` | Follow-up time / survival time |
| `status` | Event indicator |

The variable `futime` is used as survival time, while `status` is used as the event indicator.

---

## Methodology

The analysis workflow consists of:

1. **Data Preparation**
   - Import dataset
   - Remove unnecessary columns
   - Rename variables
   - Round selected numeric variables
   - Define survival object using `Surv()`

2. **Kaplan-Meier Survival Analysis**
   - Overall survival curve
   - Survival curve by age group
   - Survival curve by BMI group
   - Survival curve by weight group
   - Survival curve by height group

3. **Log-Rank Test**
   - Compare survival curves between groups
   - Assess whether survival differences are statistically significant

4. **Cox Proportional Hazards Model**
   - Build Cox regression model using age, gender, weight, and height
   - Interpret hazard ratios and significance of predictors

5. **Model Diagnostics**
   - Test proportional hazards assumption using `cox.zph()`
   - Evaluate log-log survival plots
   - Compare observed and expected survival curves

6. **Stratified Cox Model**
   - Apply stratification for variables that may violate proportional hazards assumption
   - Compare Cox model with and without interaction terms

---

## Tools and Libraries

This project was developed using R.

Main R packages used:

- `survival`
- `ggsurvfit`
- `tidycmprsk`
- `KMsurv`
- `flexsurv`
- `tidyverse`
- `dplyr`
- `DMwR2`

---

## Repository Structure
liver-survival-analysis-cox-ph-model/
│
├── README.md
├── .gitignore
├── data/
│   └── Liver.csv
├── scripts/
│   └── survival_analysis_liver.R
├── outputs/
│   └── figures/
└── notebooks/
    └── liver_survival_analysis_report.Rmd
