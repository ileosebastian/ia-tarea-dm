#---------- realizar metricas
tp <- 74
fn <- 61
fp <- 51
tn <- 205

# Tasa total
total <- (tp + tn) / (tp + tn + fp + fn)
total # 0.713555

# Precision
precision <- tp / (tp + fp)
precision # 0.592

# Recall
recall <- tp / (tp + fn)
recall # 0.5481481

# Tasa FPR
tasa_fpr <- fp / (tn + fp)
tasa_fpr # 0.1992188

# Media F1
media_f1 <- (2 * precision * recall) / (precision + recall)
media_f1 # 0.5692308

#---------- usar funciones propias con este programa
if (!require(Metrics)) install.packages("Metrics")
if (!require(yardstick)) install.packages("yardstick")

library(Metrics)
library(yardstick)
actual <- as.numeric(as.vector(test_ds$carrera_mas_de_5_anos))
predi <- as.numeric(as.vector(predict.classes))

data_metrics <- data.frame(truth = actual, predicted = predi)


metrics <- metrics(data_metrics, truth, predicted)
