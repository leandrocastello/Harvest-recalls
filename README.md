# Harvest-recalls
This repository contains R code for the Linear Mixed Models constructed in Castello et al. (Year), **Memories of past harvests can estimate historical resource use**. Journal name. Link to paper.

The following R packages were used to analyze the data:
install.packages(c("tidyverse", " nlme, "MuMIn", "broom", "dplyr", "splines", "caret", "yardstick")

_________________________
**Data**

•	dat_good: all data used in the analyses of good recalled harvest, including scaled recalled harvest (cpue_fisherz), observed harvest (cpue_sci), fisher identification number (id), scaled age of the individuals (s.fisher.agez), fishery name (f.name), role of the fisher (f.role) as boat captain (yes or no), fishery type (industrial or artisanal), unique identifier of each observation analyzed used for cross-validation (UniqueID), scaled time elapsed (timez), scaled psychological commitment (p.percep.res.depz), scaled dependency on harvesting work (e.fish.totalz), scaled learned from others (p.others.scalez), scaled learned from family (p.family.scalez), and scaled learned alone (p.alone.scalez)

•	dat_bad: all data used in the analyses of poor recalled harvest, including scaled recalled harvest (cpue_fisherz), observed harvest (cpue_sci), fisher identification number (id), scaled age of the individuals (s.fisher.agez), fishery name (f.name), role of the fisher (f.role) as boat captain (yes or no), fishery type (industrial or artisanal), unique identifier of each observation analyzed used for cross-validation (UniqueID), scaled time elapsed (timez), scaled psychological commitment (p.percep.res.depz), scaled dependency on harvesting work (e.fish.totalz), scaled learned from others (p.others.scalez), scaled learned from family (p.family.scalez), and scaled learned alone (p.alone.scalez)

•	dat_typ: all data used in the analyses of typical recalled harvest, including scaled recalled harvest (cpue_fisherz), observed harvest (cpue_sci), fisher identification number (id), scaled age of the individuals (s.fisher.agez), fishery name (f.name), role of the fisher (f.role) as boat captain (yes or no), fishery type (industrial or artisanal), unique identifier of each observation analyzed used for cross-validation (UniqueID), scaled time elapsed (timez), scaled psychological commitment (p.percep.res.depz), scaled dependency on harvesting work (e.fish.totalz), scaled learned from others (p.others.scalez), scaled learned from family (p.family.scalez), and scaled learned alone (p.alone.scalez).

_________________________
**Scripts**

•	full models.R: first computes all possible models (for good, poor, and typical harvest) based on all predictor variables and covariates; then computes averaged models based on top models with delta AIC <2

•	best bad, good, typical models.R: computes best averaged models (for good, poor, and typical harvest) based on results from full models.R

•	simple bad, typical, good models.R: first computes simplified versions of the best models including only age of the individuals and time elapsed since the recalled harvest (for good, poor, and typical harvest); then cross-validates models; and finally calculates MAE, MAPE, and MPE

•	bad, typical, good models without covariates.R: computes models (for good, poor, and typical harvest) based only on recalled harvests without any covariate

_________________________
**Results**

_#results from: full models.R
_
  •	averaged.bad.models.delta2.rds

  •	averaged.typ.models.delta2.rds

  •	averaged.good.models.delta2.rds


_#results from: simple bad, typical, good models.R
_
  •	simple_good_model.rds

  •	simple_typ_model.rds

  •	simple_bad_model.rds

  •	simple_bad_model MAE.csv

  •	simple_bad_model MAPE.csv

  •	simple_bad_model MPE.csv

  •	simple_typ_mod MAE.csv

  •	simple_typ_mod MAPE.csv

  •	simple_typ_mod MPE.csv

  •	simple_good_mod MAE.csv

  •	simple_good_mod MAPE.csv

  •	simple_good_mod MPE.csv


_#results from: bad, typical, good models without covariates.R
_
  •	typ_mod.rds

  •	bad_mod.rds

  •	good_mod.rds
