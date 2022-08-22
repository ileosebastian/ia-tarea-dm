#---------- Predecir
# como object a utilizar para que el modelo prediga es el log_model
# como nuevos datos para los cuales se predecira el si se queda o no 5 anos
# en la NBA, usaremos al conjunto de datos de prueba o test_ds
probabilities <- predict.glm(log_model, newdata = test_ds, type = "response")
View(probabilities)

# con las probabilidades impuestas, damos paso a construir la prediccion
# determinando la siguiente regla:
# si la probabilidad es mayor al 0.5 (punto de corte), entonces si
# se queda 5 anos en la NBA, caso contrario no se queda
predict.classes <- ifelse(probabilities > 0.5, "1", "0")
View(ordered(predict.classes))
View(test_ds)

# para los siguientes pasos de evaluacion
ds_trained <- data.frame(
    jugador = test_ds$nombres,
    real = as.factor(test_ds$se_queda_5yrs_NBA),
    prediccion = as.factor(predict.classes)
)
View(ds_trained)
