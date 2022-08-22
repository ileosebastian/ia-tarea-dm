#---------- Mostrar curva ROC
roc_curve <- roc(test_ds$se_queda_5yrs_NBA, probabilities, smooth = TRUE)
plot(roc_curve)

auc(roc_curve)

# Como se pudo apreciar, la curva ROC es aceptable dentro del dataset utilizado
# puesto que el area bajo la curva es 0.7407
