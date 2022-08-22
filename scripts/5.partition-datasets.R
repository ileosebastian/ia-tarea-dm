#---------- Definir el conjunto de la muestra
# dividir muestra en 70/30
set.seed(2001)
id_instances <- sample(
    seq_along(dataset$se_queda_5yrs_NBA), nrow(dataset) * .70
)
training_ds <- dataset[id_instances, ] # 909 registros
View(training_ds)
test_ds <- dataset[-id_instances, ] # 391 registros
View(test_ds)
