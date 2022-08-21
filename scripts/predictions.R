#---------- Predecir
probabilities <- predict(log_model, newdata = test_ds, type="response")
predict.classes <- ifelse(probabilities > 0.5, "1", "0")
predict.classes
ordered(predict.classes)

test_ds$predict <- predict.classes
prediction <- data.frame(test_ds$carrera_mas_de_5_anos, test_ds$predict)
