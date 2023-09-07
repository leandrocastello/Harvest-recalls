# Harvest-recalls
This repository contains R code for the Linear Mixed Models constructed in Castello et al. (Year), Local knowledge reconstructs historical resource use. Journal name. Link to paper.

The following R packages were used to analyze the data:
```
install.packages(c("tidyverse", " nlme, "MuMIn", "broom", "dplyr", "splines", "caret", "yardstick")
```
_________________________
## **Data**

* `dat`: all data used in the analyses of harvest recalls, including recalled harvest (cpue_fisher), observed harvest (cpue_sci), fisher identification number (fisher.id), age of the individuals (s.fisher.age), fishery name (f.name), unique identifier of each observation analyzed used for cross-validation (UniqueID), time elapsed (time), and type of harvest recall measure (recall.type).  All continuous predictor variables are scaled.

_________________________
## **Scripts**

* `accuracy analysis.R`: first it computes all possible models (for good, poor, and typical harvest) based on time and age as predictors and difference between recalled and observed harvests as response; then it computes averaged models based on all models comprising at least 95% of cumulative AICc weights 

* `reliability analysis.R`: using filtered data of recalls (based on results from accuracy analysis), it runs LMM between recalled harvest (as response) and observed harvest (as predictor). Predictor variable is not scaled.

* `cross-validation.R`: does a five-fold cross-validation of model used in reliability analysis, and uses the outputs to calculate median absolute percentage error (MAPE) and median percentage error (MPE)

_________________________
## **Results**

##### *Results from script:* `accuracy analysis.R`

 * `accuracy.avg.model.rds`
 
 
##### *Results from script:* `reliability analysis.R`

 * `reliability.model.rds`
 
 
##### *Results from script:* `cross-validation.R`

 * `MAPE_data.csv`

 *  `MPE_data.csv`
