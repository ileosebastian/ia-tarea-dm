# Cargar librerías y set de datos-----------------------------------------------
if (!require(tidyverse)) {
  install.packages("tidyverse")
}
if (!require(stringr)) {
  install.packages("stringr")
}
if (!require(caret)) {
  install.packages("caret")
}
if (!require(gmodels)) {
  install.packages("gmodels")
}
if (!require(ROCR)) {
  install.packages("ROCR")
}

library(tidyverse)
library(stringr)
library(caret)
library(gmodels)
library(ROCR)

data <- read.csv("Datos/nba-players.csv")

#Realizar la exploración de los datos (tipo de datos, mostrar los datos)
summary(data)
glimpse(data)
#view(data)

#Preparar set de datos----------------------------------------------------------
data$name <-
  str_replace_all(data$name, "[^[:alnum:] ]", "")#eliminar caracteres especiales

if (has_element(is.na(data), TRUE)) {
  print("Tiene valores nulos")# ver si tiene datos nulos
}

if (has_element(duplicated(data), TRUE)) {
  data <- unique(data)#se eliminan los registros duplicados
}

#La variable dependiente o variable objetivo debe ser de tipo factor
data$target_5yrs <- as.factor(data$target_5yrs)

#Elaborar el modelo-------------------------------------------------------------

#Definir el conjunto de la muestra (entrenamiento y test) 70/30
training.ids <- createDataPartition(data$gp , p = 0.7, list = FALSE)

entrenamiento <- data[training.ids,]
prueva <- data[-training.ids,]

#Construir el modelo de predicción
logistico <-
  glm(target_5yrs ~ gp, data = entrenamiento, family = binomial)

#Presentar el resumen del modelo
summary(logistico)

#Realizar las predicciones
prediccion <- predict(logistico, newdata = prueva, type = "response")
prueva$predic <- trunc(prediccion + 0.5)
predict <- data.frame(prueva$target_5yrs, prueva$predic)
predict

#Evaluar la efectividad del modelo----------------------------------------------

#Dibujar la curva ROC
pred <- prediction(prueva$gp, prueva$target_5yrs, label.ordering = c("non-buyer", "buyer"))
perf <- performance(pred, "tpr", "fpr")
plot(perf, main="CURVA de ROC")
lines( par()$usr[1:2], par()$usr[3:4] )

plot(perf, colorize=TRUE, print.cutoffs.at=seq(0,1,by=0.1), text.adj=c(-0.2,1.7))

# curve(log(x), from=0, to=100, xlab="Tasa de falsos positivos", ylab="Tasa de verdaderos positivos",
#       main="CURVA ROC", col="green", lwd=3, axes=F)
# Axis(side=1, at=c(0, 20, 40, 60, 80, 100), labels = c("0%", "20%", "40%", "6
# 0%", "80%", "100%"))
# Axis(side=2, at=0:5, labels = c("0%", "20%", "40%", "60%", "80%", "100%"))
# segments(0, 0, 110, 5, lty=2, lwd=3)
# segments(0, 0, 0, 4.7, lty=2, lwd=3, col="blue")
# segments(0, 4.7, 107, 4.7, lty=2, lwd=3, col="blue")
# text(20, 4, col="blue", labels = "Clasificador perfecto")
# text(40, 3, col="green", labels = "Clasificador de prueba")
# text(70, 2, col="black", labels= "Clasificador sin valor predictivo")


#Matriz de confusión
CrossTable(prueva$target_5yrs, floor(prediccion+0.5))

