#############################################################################################
#############################################################################################
#COMPUTE  BAD, GOOD, TYPICAL MODELS, CROSS-VALIDATE THEM, AND CALCULATE MAE, MAPE, MPE
#############################################################################################
#############################################################################################
setwd("~/Documents/Research/Pew Fellowship/Data analysis/Fishers memory II/Fishers-knowledge")
library(broom)
library(nlme)
library(dplyr)

##########################################################
# TYPICAL MODEL
typ_mod<- lme(cpue_sci ~ cpue_fisherz,  random = list(f.name = ~ 1, id = ~1),
              data = dat_typ, weights = varFixed(~cpue_sci), method = "ML")

summary(typ_mod)
saveRDS(list(data=dat_typ,model=typ_mod), "typ_mod.rds")

##########################################################
# BAD MODEL
bad_mod<- lme(cpue_sci ~ cpue_fisherz, random = list(f.name = ~ 1, id = ~1),
              data = dat_bad, weights = varFixed(~cpue_sci), method = "ML")
summary(bad_mod)
saveRDS(list(data=dat_bad,model=bad_mod), "bad_mod.rds")

##########################################################
# GOOD MODEL
good_mod<- lme(cpue_sci ~ cpue_fisherz, random = list(f.name = ~ 1, id = ~1),
              data = dat_good, weights = varFixed(~cpue_sci), method = "ML")
summary(good_mod)
saveRDS(list(data=dat_good,model=good_mod), "good_mod.rds")
