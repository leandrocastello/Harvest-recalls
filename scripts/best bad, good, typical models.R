library(MuMIn)
library(nlme)

##########################################################
# RUNNING BEST AVERAGED BAD MODEL
##########################################################
best_bad_model <- lme(cpue_sci ~ cpue_fisherz +
                        f.type +
                        s.fisher.agez +
                        timez +
                        cpue_fisherz:f.type +
                        cpue_fisherz:s.fisher.agez +
                        cpue_fisherz:timez +
                        p.percep.res.depz +           
                        cpue_fisherz:p.percep.res.depz +
                        p.alone.scalez +
                        e.fish.totalz +
                        p.others.scalez,
                      random = list(f.name = ~ 1, id = ~1),
                      data = dat_bad, weights = varFixed(~cpue_sci), method = "ML")

plot(best_bad_model)
summary(best_bad_model)

##########################################################
# RUNNING BEST AVERAGED GOOD MODEL
##########################################################
best_good_model <- lme(cpue_sci ~ cpue_fisherz +
                         f.role +
                         f.type +
                         p.alone.scalez +
                         s.fisher.agez +
                         timez +
                         cpue_fisherz:f.role +
                         cpue_fisherz:f.type +
                         cpue_fisherz:p.alone.scalez +
                         cpue_fisherz:s.fisher.agez +
                         cpue_fisherz:timez  +
                         p.percep.res.depz +
                         e.fish.totalz +
                         p.others.scalez,
                       random = list(f.name = ~ 1, id = ~1),
                       data = dat_good, weights = varFixed(~cpue_sci), method = "ML")

plot(best_good_model)
summary(best_good_model)

##########################################################
# RUNNING BEST AVERAGED TYPICAL MODEL
##########################################################
best_typ_model <- lme(cpue_sci ~ cpue_fisherz +
                        p.alone.scalez +
                        s.fisher.agez +
                        timez +
                        cpue_fisherz:p.alone.scalez +
                        cpue_fisherz:s.fisher.agez +
                        cpue_fisherz:timez +
                        p.family.scalez +
                        cpue_fisherz:p.family.scalez +
                        e.fish.totalz +
                        p.others.scalez +
                        p.percep.res.depz, 
                      random = list(f.name = ~ 1, id = ~1),
                      data = dat_typ, weights = varFixed(~cpue_sci), method = "ML")


plot(best_typ_model)
summary(best_typ_model)

