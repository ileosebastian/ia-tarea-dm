#---------- Evaluar necesidad y aplicabilidad
ds <- nba_players_clear # establecido el conjunto de datos a usar en adelante

# listas de los nombres de las variables del ds
varlist <- ds %>% select(-nombres, -carrera_mas_de_5_anos) %>% names(.)
linear_model_lists  <- list()
significance_level  <- 0.05 # 5% aceptable para este modelo
hightest_level_sig <-  0 # sabiendo que la significancia es <= 0.05
name_var_sig <- ""
for (i in seq_along(varlist)) {
  mod <- as.formula(sprintf("carrera_mas_de_5_anos ~ %s", varlist[i]))
  linear_model_lists[[varlist[i]]] <- glm(
    formula = mod,
    data = ds,
    family = binomial
  )
  tmp <- linear_model_lists[[varlist[i]]]$coefficients[2]
  if (tmp <= 0.055 && tmp >= hightest_level_sig) {
    hightest_level_sig <- tmp
  }
  print(hightest_level_sig)
}

print(hightest_level_sig) # es "juegos_jug"
# como se puede apreciar, tras evaluar en todos los atributos el nivel de
# significancia, vemos que gp o juegos jugados cumple con el valor dicho (0.05)
# por lo tanto, juegos_jug sera la variable x del modelo
# entendiendo que la variable y sera carrera_mas_de_5_anos

#---------- Variable dependiente (y) tipo factor
ds$carrera_mas_de_5_anos <- as.factor(ds$carrera_mas_de_5_anos)
levels(ds$carrera_mas_de_5_anos) # 0 => No se queda 5 anos, se queda 5 anos
tibble::as_tibble(ds)

# Por lo anterior mencionado, solo se usara los siguientes campos para los
# siguientes pasos:
# nombres
# x ~ juegos_jug
# y ~ carrera_mas_de_5_anos
dataset  <- data.frame(
    nombres = ds$nombres,
    juegos_jugados = ds$juegos_jug,
    se_queda_5yrs_NBA = ds$carrera_mas_de_5_anos
)
View(dataset)
