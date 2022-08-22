# ---------- realizar metricas
tp <- 205 # true positives
fp <- 51 # false positives
fn <- 61 # false negatives
tn <- 74 # true negatives

# Tasa total
total <- (tp + tn) / (tp + tn + fp + fn)
total # 0.713555 ~ 0.7136
# esto quiere decir que hay una tasa del 71% de correcta clasificacion en
# las observaciones dadas

# Precision
preci <- tp / (tp + fp)
preci # 0.8007812
# esto quiere decir que en el modelo esta acertando un 80% de los casos
# en otras palabras, se equivocara en decir que un jugador va a estar en NBA
# un 20% de los casos

# Recall
re_call <- tp / (tp + fn)
re_call # 0.7706767
# esto quiere decir que el modelo es capaz de identificar a un 77% de jugadores
# como personas que se quedan mas de 5 anos en la NBA segun lo observado

# Tasa FP (Falsos positivos)
tasa_fp <- fp / (fp + tn)
tasa_fp # 0.408
# esto quiere decir que la tasa de error es del 40.8%
# lo cual hace bastante probable que el modelo pase por alto a un verdadero
# positivo

# Media F1
media_f1 <- (2 * preci * re_call) / (preci + re_call)
media_f1 # 0.7854406
# esto quiere decir que la media entre la precision y el recall es
# del 78%, lo cual nos dice que el modelo identifica bien los verdaderos
# positivos en cuestion de cantidad y calidad


# ---------- usar funciones propias con este programa
caret::recall(confusion_matrix)
caret::precision(confusion_matrix)
F_meas(confusion_matrix)

# para el calcular tasa total y tasa fp
cm <- confusionMatrix(ds_trained$real, ds_trained$prediccion)
cm # aqui se encuentra el accuracy o tasa total

fpr(fp, tn)
