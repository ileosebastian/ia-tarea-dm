#---------- Evaluar necesidad y aplicabilidad
data <- nba_players.clear
sample.log1 <- glm(
  formula = carrera_mas_de_5_anos ~ puntos,
  data = data,
  family = binomial
)
print(summary(sample.log1)$coef)

varlist <- data %>% select(-nombres, -carrera_mas_de_5_anos) %>% names(.)
sample.LOG  <- list()
x_mayor_significancia <-  0
for (i in seq_along(varlist)) {
  mod <- as.formula(sprintf("carrera_mas_de_5_anos ~ %s", varlist[i]))
  sample.LOG[[varlist[i]]] <- glm(formula = mod, data = data, family = binomial)
  tmp <- sample.LOG[[varlist[i]]]$coefficients[2]
  if (tmp >= x_mayor_significancia) {
    x_mayor_significancia <- tmp
  }
}

x_mayor_significancia # es "roba"


#---------- Variable dependiente tipo factor
data$carrera_mas_de_5_anos <- as.factor(data$carrera_mas_de_5_anos)
levels(data$carrera_mas_de_5_anos) # 0 => No se queda 5 anos, se queda 5 anos
