
library(mlr)

# Data of 11 Huawai Smartphones

nazwa <- c("Smartfon_1","Smartfon_2","Smartfon_3","Smartfon_4","Smartfon_5",
           "Smartfon_6","Smartfon_7","Smartfon_8","Smartfon_9",
           "Smartfon_10","Smartfon_11")
wyswietlacz <-c(6.7,6.7,5.9,6.4,6.7,6.5,6.1,6.2,6.7,6.7, 5.8)
pamiec_RAM <-c(8,6,4,4,6,4,8,2,8,6, 3)
pamiec_wbudowana <-c(128,128,64,64,128,128,128,32,128, 128, 32)
aparat_foto <-c(64,64,16,25,32,48,16,13,48,12, 13)
cena <-c(3949, 1999, 999, 849,1499, 1699, 3299,699,2799,2649, 749)
liczba_opinii <-c(7,38,20,21,65,20,77,22,10,8, 42)
ocena_klientow <- c(3, 1, 2, 2, 2, 3, 3, 2, 4, 3, 2)

# Uwzględnia wyswietlacz, RAM, pamiec wbudowana, aparat i opinie

smartphones <- data.frame(wyswietlacz, pamiec_RAM, pamiec_wbudowana, aparat_foto, ocena_klientow)


## MAKE RESAMPLING STRATEGY
rdesc = makeResampleDesc(method = "CV", stratify = F)

#MAKE CLASSIF TASK############################################################################################################
smartphones$ocena_klientow <- as.factor(smartphones$ocena_klientow)
classif.task = makeClassifTask(id = "smartphones - ocena klientow - MMCE", data = smartphones, target = "ocena_klientow", fixup.data = "no")
classif.task

#listLearners("classif")[c("class", "package")]

## Default values
classif.learners = makeLearners(c("nnet", "lda", "randomForest", "C50", "rpart"), type = "classif", fix.factors.prediction=TRUE)

classif.comparison = benchmark(learners = classif.learners, tasks = classif.task, resamplings = rdesc)

## Results for classif, MMCE - Mean misclassification error

classif.comparison

getBMRAggrPerformances(classif.comparison)
getBMRPerformances(classif.comparison)
plotBMRBoxplots(classif.comparison)





