#############################################################################################
#############################################################################################
#COMPUTE SIMPLE BAD, GOOD, TYPICAL MODELS, CROSS-VALIDATE THEM, AND CALCULATE MAE, MAPE, MPE
#############################################################################################
#############################################################################################
library(MuMIn)

##########################################################
# COMPUTE SIMPLE BAD MODEL
##########################################################
simple_bad_model <- lme(cpue_sci ~ cpue_fisherz +
                          s.fisher.agez +
                          timez +
                          cpue_fisherz:s.fisher.agez +
                          cpue_fisherz:timez, 
                        random = list(f.name = ~ 1, id = ~1),
                        data = dat_bad, weights = varFixed(~cpue_sci), method = "ML")
summary(simple_bad_model)
saveRDS(list(data=dat_bad,model=simple_bad_model), "simple_bad_model.rds")


##########################################################
#CROSS-VALIDATE SIMPLE BAD MODEL & CALCULATE MAE | MAPE | MPE
##########################################################
library(splines)
library(caret)#we will use this for cross validation
library(yardstick)

# CREATING FOLDS AND DATAFRAMES
all_participants<-unique(dat_bad[['UniqueID']])
#we create cross validation folds using caret's createFolds
num_folds <- 5
folds<-createFolds(all_participants,k=num_folds,list=TRUE,returnTrain=TRUE)
#data structures to hold results
Bad_MAE_within_subjects_lmm <- c()
Bad_MAPE_within_subjects_lmm <- c()
Bad_MPE_within_subjects_lmm <- c()

# CROSS=VALIDATING
for(i in 1:num_folds){
  train_ids<- folds[[i]]
  test_ids<-all_participants[!(all_participants%in%folds[[i]])]
  #generate train/test
  test<-subset(dat_bad,UniqueID%in%train_ids)
  train<-subset(dat_bad,UniqueID%in%test_ids)
  #fit models
  test_participants <- unique(test[['UniqueID']])
  for(participant in test_participants){
    prediction_subset <- subset(test,UniqueID==participant)
    #predict
    y_pred_lmm <- predict(simple_bad_model,newdata=prediction_subset,allow.new.levels=TRUE)
    y_true <- prediction_subset[['cpue_sci']]
    Bad_MAE_within_subjects_lmm<- c(Bad_MAE_within_subjects_lmm, MAE(y_true, y_pred_lmm))
    Bad_MAPE_within_subjects_lmm<- c(Bad_MAPE_within_subjects_lmm, mape_vec(y_true, y_pred_lmm))
    Bad_MPE_within_subjects_lmm<- c(Bad_MPE_within_subjects_lmm, mpe_vec(y_pred_lmm, y_true))
    
  }
}

# MAE FOR SIMPLE BAD MODEL
simple_bad_MAE <- as.array(summary(Bad_MAE_within_subjects_lmm))
write.csv(simple_bad_MAE, file = "simple_bad_model MAE.csv")

# MAPE FOR SIMPLE BAD MODEL
simple_bad_MAPE <- as.array(summary(Bad_MAPE_within_subjects_lmm))
write.csv(simple_bad_MAPE, file = "simple_bad_model MAPE.csv")

# MPE FOR SIMPLE BAD MODEL
simple_bad_MPE <- as.array(summary(Bad_MPE_within_subjects_lmm))
write.csv(simple_bad_MPE, file = "simple_bad_model MPE.csv")


##########################################################
# TYPICAL MODEL
##########################################################
simple_typ_model <- lme(cpue_sci ~ cpue_fisherz +
                          s.fisher.agez +
                          timez +
                          cpue_fisherz:s.fisher.agez +
                          cpue_fisherz:timez, 
                        random = list(f.name = ~ 1, id = ~ 1),
                        data = dat_typ, weights = varFixed(~cpue_sci), method = "ML")

summary(simple_typ_model)
saveRDS(list(data=dat_typ,model=simple_typ_model), "simple_typ_model.rds")

##########################################################
#CROSS-VALIDATING SIMPLE TYPICAL MODEL -- MAE | MAPE | MPE
##########################################################
library(splines)
library(caret)#we will use this for cross validation
library(yardstick)

# CREATING FOLDS AND DATAFRAMES
all_participants<-unique(dat_typ[['UniqueID']])
#we create cross validation folds using caret's createFolds
num_folds <- 5
folds<-createFolds(all_participants,k=num_folds,list=TRUE,returnTrain=TRUE)
#data structures to hold results
Typical_MAE_within_subjects_lmm <- c()
Typical_MAPE_within_subjects_lmm <- c()
Typical_MPE_within_subjects_lmm <- c()

# CROSS=VALIDATING
for(i in 1:num_folds){
  train_ids<- folds[[i]]
  test_ids<-all_participants[!(all_participants%in%folds[[i]])]
  #generate train/test
  test<-subset(dat_typ,UniqueID%in%train_ids)
  train<-subset(dat_typ,UniqueID%in%test_ids)
  #fit models
  test_participants <- unique(test[['UniqueID']])
  for(participant in test_participants){
    prediction_subset <- subset(test,UniqueID==participant)
    #predict
    y_pred_lmm <- predict(simple_typ_model,newdata=prediction_subset,allow.new.levels=TRUE)
    y_true <- prediction_subset[['cpue_sci']]
    Typical_MAE_within_subjects_lmm<- c(Typical_MAE_within_subjects_lmm, MAE(y_true, y_pred_lmm))
    Typical_MAPE_within_subjects_lmm<- c(Typical_MAPE_within_subjects_lmm, mape_vec(y_true, y_pred_lmm))
    Typical_MPE_within_subjects_lmm<- c(Typical_MPE_within_subjects_lmm, mpe_vec( y_pred_lmm, y_true))
    
  }
}

# MAE FOR SIMPLE TYPICAL MODEL
simple_typ_MAE <- as.array(summary(Typical_MAE_within_subjects_lmm))
write.csv(simple_typ_MAE, file = "simple_typ_mod MAE.csv")

# MAPE FOR SIMPLE TYPICAL MODEL
simple_typ_MAPE <- as.array(summary(Typical_MAPE_within_subjects_lmm))
write.csv(simple_typ_MAPE, file = "simple_typ_mod MAPE.csv")

# MPE FOR SIMPLE TYPICAL MODEL
simple_typ_MPE <- as.array(summary(Typical_MPE_within_subjects_lmm))
write.csv(simple_typ_MPE, file = "simple_typ_mod MPE.csv")

##########################################################
# GOOD MODEL
##########################################################
simple_good_model <- lme(cpue_sci ~ cpue_fisherz +
                           s.fisher.agez +
                           timez +
                           cpue_fisherz:s.fisher.agez +
                           cpue_fisherz:timez, 
                         random = list(f.name = ~ 1, id = ~1),
                         data = dat_good, weights = varFixed(~cpue_sci), method = "ML")
summary(simple_good_model)
saveRDS(list(data=dat_good,model=simple_good_model), "simple_good_model.rds")

##########################################################
#CROSS-VALIDATING SIMPLE GOOD MODEL -- MAE | MAPE | MPE
##########################################################
library(splines)
library(caret)#we will use this for cross validation
library(yardstick)

# CREATING FOLDS AND DATAFRAMES
all_participants<-unique(dat_good[['UniqueID']])
#we create cross validation folds using caret's createFolds
num_folds <- 5
folds<-createFolds(all_participants,k=num_folds,list=TRUE,returnTrain=TRUE)
#data structures to hold results
Good_MAE_within_subjects_lmm <- c()
Good_MAPE_within_subjects_lmm <- c()
Good_MPE_within_subjects_lmm <- c()

# CROSS=VALIDATING
for(i in 1:num_folds){
  train_ids<- folds[[i]]
  test_ids<-all_participants[!(all_participants%in%folds[[i]])]
  #generate train/test
  test<-subset(dat_good,UniqueID%in%train_ids)
  train<-subset(dat_good,UniqueID%in%test_ids)
  #fit models
  test_participants <- unique(test[['UniqueID']])
  for(participant in test_participants){
    prediction_subset <- subset(test,UniqueID==participant)
    #predict
    y_pred_lmm <- predict(simple_good_model,newdata=prediction_subset,allow.new.levels=TRUE)
    y_true <- prediction_subset[['cpue_sci']]
    Good_MAE_within_subjects_lmm<- c(Good_MAE_within_subjects_lmm, MAE(y_true, y_pred_lmm))
    Good_MAPE_within_subjects_lmm<- c(Good_MAPE_within_subjects_lmm, mape_vec(y_true, y_pred_lmm))
    Good_MPE_within_subjects_lmm<- c(Good_MPE_within_subjects_lmm, mpe_vec(y_pred_lmm, y_true))
    
  }
}

# MAE FOR SIMPLE GOOD MODEL
simple_good_MAE <- as.array(summary(Good_MAE_within_subjects_lmm))
write.csv(simple_good_MAE, file = "simple_good_mod MAE.csv")

# MAPE FOR SIMPLE GOOD MODEL
simple_good_MAPE <- as.array(summary(Good_MAPE_within_subjects_lmm))
write.csv(simple_good_MAPE, file = "simple_good_mod MAPE.csv")

# MPE FOR SIMPLE GOOD MODEL
simple_good_MPE <- as.array(summary(Good_MPE_within_subjects_lmm))
write.csv(simple_good_MPE, file = "simple_good_mod MPE.csv")

