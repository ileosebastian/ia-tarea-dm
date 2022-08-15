# Desarrollar el problema de regresión logística binaria, 
# para predecir la duración de la carrera de
# un jugador de 5 años o más años (binario).

#---------- Carga y preparacion de datos
# Cargar librerias
if (!require(tidyverse)) {install.packages("tidyverse")}
if (!require(dplyr)) {install.packages("dplyr")}
if (!require(stats)) {install.packages("stats")}
if (!require(stringr)) {install.packages("stringr")}
if (!require(caret)) {install.packages("caret")}
if (!require(gmodels)) {install.packages("gmodels")}
if (!require(ROCR)) {install.packages("ROCR")}

library("tidyverse")
library("dplyr")
library("stats")
library("stringr")
library("caret")
library("gmodels")
library("ROCR")

# Cargar set de datos
nba_players <- read.csv("./nba-players_2.csv", sep=";")

nba_players <- as.data.frame(nba_players)

str(nba_players)

# mostrar datos
glimpse(nba_players)

#---------- Limpiar datos
# Cambio de nombre de columnas
nba_players.clear <- nba_players %>%
  rename(
    nombres=name,
    juegos_jug=gp,
    minutos_jug=min,
    puntos=pts,
    goles_campo_hechos=fgm,
    intentos_gol_campo=fga,
    porcen_goles_campo=fg,
    tres_pnts_hechos=X3p_made,
    intentos_tres_pnts=X3pa,
    porcen_tres_pnts=X3p,
    tiro_libre_hecho=ftm,
    tiro_libre_intentado=fta,
    porcen_tiro_libre=ft,
    rebotes_ofensivos=oreb,
    rebotes_defensivos=dreb,
    rebotes=reb,
    asistencias=ast,
    roba=stl,
    bloqueo=blk,
    perdidas_balon=tov,
    carrera_mas_de_5_anos=target_5yrs
  ) %>% 
  select(-X)


# eliminar registros nulos
nba_players.clear <- na.omit(nba_players.clear)
sapply(nba_players.clear, function(x) sum(is.na(x)))

# eliminar registros duplicados completos (fila n = fila m)
nba_players.clear <- unique(nba_players.clear)

#---------- Evaluar necesidad y aplicabilidad
data <- nba_players.clear
sample.log1 <- glm(
  formula = carrera_mas_de_5_anos ~ puntos,
  data = data,
  family = binomial
)
print(summary(sample.log1)$coef)

varlist <- data %>% select(-nombres,-carrera_mas_de_5_anos) %>% names(.)
sample.LOG = list()
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

#---------- Elaborar modelo



#---------- Definir el conjunto de la muestra
# dividir muestra
set.seed(2001)
id_instances.seven <- sample(1:nrow(data), nrow(data)*.70)
training_ds <- data[id_instances.seven,]
test_ds <- data[-id_instances.seven,]

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


#---------- Predecir
probabilities <- predict(log_model, newdata = test_ds, type="response")
predict.classes <- ifelse(probabilities > 0.5, "1", "0")
predict.classes
ordered(predict.classes)

test_ds$predict <- predict.classes
prediction <- data.frame(test_ds$carrera_mas_de_5_anos, test_ds$predict)


#---------- Mostrar curva ROC
pred <- prediction(test_ds$juegos_jug, test_ds$carrera_mas_de_5_anos)
perf <- performance(pred, "tpr", "fpr")
plot(perf, main="Curva ROC")
lines(par()$usr[1:2], par()$usr[3:4])

#---------- Evaluacion de efectividad del modelo



#---------- Matriz de confusion
confusion_matrix <- CrossTable(test_ds$carrera_mas_de_5_anos, predict.classes)
