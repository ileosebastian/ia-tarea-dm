#---------- Construir modelo de prediccion
log_model <- glm(
  formula = se_queda_5yrs_NBA ~ juegos_jugados,
  data = training_ds,
  family = binomial
)

#---------- Resumen del modelo
summary(log_model)

#---------- Mostrar variables significativas
print(summary(log_model)$coef)
