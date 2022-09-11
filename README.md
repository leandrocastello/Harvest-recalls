# Harvest-recalls
This repository contains R code for the Linear Mixed Models constructed in Castello et al. (Year), Local knowledge reconstructs historical resource use. Journal name. Link to paper.

The following R packages were used to analyze the data:
```
install.packages(c("tidyverse", " nlme, "MuMIn", "broom", "dplyr", "splines", "caret", "yardstick")
```
_________________________
## **Data**

* `dat`: all data used in the analyses of harvest recalls, including recalled harvest (cpue_fisher), observed harvest (cpue_sci), fisher identification number (fisher.id), age of the individuals (s.fisher.age), fishery name (f.name), unique identifier of each observation analyzed used for cross-validation (UniqueID), time elapsed (time), and type of harvest recall measure (recall.type).

_________________________
## **Scripts**

* `full models.R`: first it computes all possible models (for good, poor, and typical harvest) based on all predictor variables and covariates; then it computes averaged models based on top models with delta AIC <2

* `best bad, good, typical models.R`: it simply computes "best" averaged models (for good, poor, and typical harvest) based on results from `full models.R` so they can be plotted in Fig. 2A of the paper

* `simple bad, typical, good models.R`: first it computes simplified versions of the best models including only age of the individuals and time elapsed since the recalled harvest (for good, poor, and typical harvest). These are plotted in Fig. 2B of the paper; finally it does a five-fold cross-validation of these models and uses the outputs to calculate median absolute percentage error (MAPE) and median percentage error (MPE), which are plotted in Fig 4A-B of the paper

* `bad, typical, good models without covariates.R`: it computes models (for good, poor, and typical harvest) based only on recalled harvests without any covariate, which are plotted in Fig. 4C of the paper

_________________________
## **Results**

##### *Results from script:* `full models.R`

 * `averaged.bad.models.delta2.rds`

 * `averaged.typ.models.delta2.rds`

 * `averaged.good.models.delta2.rds`
 

##### *Results from script:* `best bad, good, typical models.R`

 * `best_typ_model.rds`
 
 * `best_bad_model.rds`
 
 * `best_good_model.rds`


##### *Results from script:* `simple bad, typical, good models.R`

 * `simple_good_model.rds`

 * `simple_typ_model.rds`

 * `simple_bad_model.rds`

 * `simple_bad_model MAPE.csv`

 * `simple_bad_model MPE.csv`

 * `simple_typ_mod MAPE.csv`

 * `simple_typ_mod MPE.csv`

 * `simple_good_mod MAPE.csv`

 * `simple_good_mod MPE.csv`


##### *Results from script:* `bad, typical, good models without covariates.R`

  * `typ_mod.rds`

  * `bad_mod.rds`

  * `good_mod.rds`
