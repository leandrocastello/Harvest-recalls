library(nlme)
library(tidyverse)
library(MuMIn)

##########################################################
# COMPUTE FULL GOOD MODEL 
##########################################################
 full_good_mod <- lme(cpue_sci ~ cpue_fisherz +
                        e.fish.totalz +
                        s.fisher.agez +
                        f.role +
                        f.type +
                        p.others.scalez +
                        p.alone.scalez +
                        p.family.scalez +
                        p.percep.res.depz +
                        timez +
                        cpue_fisherz:e.fish.totalz +
                        cpue_fisherz:f.role +
                        cpue_fisherz:f.type +
                        cpue_fisherz:p.others.scalez +
                        cpue_fisherz:p.alone.scalez +
                        cpue_fisherz:p.family.scalez +
                        cpue_fisherz:p.percep.res.depz +
                        cpue_fisherz:s.fisher.agez + 
                        cpue_fisherz:timez, 
                      random = list(f.name = ~ 1, id = ~1),
               data = dat_good, weights = varFixed(~cpue_sci), method = "ML")
plot(full_good_mod)

# PRODUCE ALL POSSIBLE MODELS
modsel_good <- dredge(full_good_mod, fixed = "cpue_fisherz")
 write.csv(modsel_good, file = "modsel_good.csv")
 # selects models with delta AIC < 2
 good.models <- get.models(modsel_good, subset = delta < 2, method = "REML")
 
 # average models with delta AIC < 2
 averaged.good.models <- model.avg(good.models)
 
 # Saving models
 saveRDS(list(data=dat_good,model=averaged.good.models), "averaged.good.models.delta2.rds")
 summary(averaged.good.models)

##########################################################
 # COMPUTE FULL BAD MODEL 
##########################################################
 full_bad_mod <- lme(cpue_sci ~ cpue_fisherz +
                       e.fish.totalz +
                       s.fisher.agez +
                    `` f.role +
                       f.type +
                       p.others.scalez +
                       p.alone.scalez +
                       p.family.scalez +
                       p.percep.res.depz +
                       timez +
                       cpue_fisherz:e.fish.totalz +
                       cpue_fisherz:f.role +
                       cpue_fisherz:f.type +
                       cpue_fisherz:p.others.scalez +
                       cpue_fisherz:p.alone.scalez +
                       cpue_fisherz:p.family.scalez +
                       cpue_fisherz:p.percep.res.depz +
                       cpue_fisherz:s.fisher.agez + 
                       cpue_fisherz:timez, 
                     random = list(f.name = ~ 1, id = ~1),
                      data = dat_bad, weights = varFixed(~cpue_sci), method = "ML")
 plot(full_bad_mod)
 
 # PRODUCE ALL POSSIBLE MODELS
 modsel_bad <- dredge(full_bad_mod, fixed = "cpue_fisherz")
 write.csv(modsel_bad, file = "modsel_bad.csv")
 # selects models with delta AIC < 2
 bad.models <- get.models(modsel_bad, subset = delta < 2, method = "REML")
 
 # average models with delta AIC < 2
 averaged.bad.models <- model.avg(bad.models)
 
 # Saving models
 saveRDS(list(data=dat_bad,model=averaged.bad.models), "averaged.bad.models.delta2.rds")
 summary(averaged.bad.models)
 
 ########################################################## 
 # COMPUTE FULL TYPICAL MODEL 
 ##########################################################
  full_typ_mod <- lme(cpue_sci ~ cpue_fisherz +
                       e.fish.totalz +
                       s.fisher.agez +
                     f.role +
                       f.type +
                       p.others.scalez +
                       p.alone.scalez +
                       p.family.scalez +
                       p.percep.res.depz +
                       timez +
                       cpue_fisherz:e.fish.totalz +
                       cpue_fisherz:f.role +
                       cpue_fisherz:f.type +
                       cpue_fisherz:p.others.scalez +
                       cpue_fisherz:p.alone.scalez +
                       cpue_fisherz:p.family.scalez +
                       cpue_fisherz:p.percep.res.depz +
                       cpue_fisherz:s.fisher.agez + 
                       cpue_fisherz:timez, 
                     random = list(f.name = ~ 1, id = ~1),
                     data = dat_typ, weights = varFixed(~cpue_sci), method = "ML")
 plot(full_typ_mod)
 
 # PRODUCE ALL POSSIBLE MODELS
 modsel_typ <- dredge(full_typ_mod, fixed = "cpue_fisherz")
 write.csv(modsel_typ, file = "modsel_typ.csv")
 # select models with delta AIC < 2
 typ.models <- get.models(modsel_typ, subset = delta < 2, method = "REML")
 
 # averages models with delta AIC < 2
 averaged.typ.models <- model.avg(typ.models)
 
 # Saving models
 saveRDS(list(data=dat_typ,model=averaged.typ.models), "averaged.typ.models.delta2.rds")
 summary(averaged.typ.models)
