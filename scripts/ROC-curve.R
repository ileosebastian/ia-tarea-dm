#---------- Mostrar curva ROC
pred <- prediction(test_ds$juegos_jug, test_ds$carrera_mas_de_5_anos)
perf <- performance(pred, "tpr", "fpr")
plot(perf, main="Curva ROC")
lines(par()$usr[1:2], par()$usr[3:4])
