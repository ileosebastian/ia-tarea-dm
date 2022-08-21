#---------- Construir modelo de prediccion
log_model <- glm(
  formula = carrera_mas_de_5_anos ~ juegos_jug,
  data = training_ds,
  family = binomial
)

#---------- Resumen del modelo
summary(log_model)

#---------- Mostrar variables significativas
print(summary(log_model)$coef)
