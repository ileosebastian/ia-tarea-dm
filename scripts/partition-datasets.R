#---------- Definir el conjunto de la muestra
# dividir muestra
set.seed(2001)
id_instances.seven <- sample(1:nrow(data), nrow(data) * .70)
training_ds <- data[id_instances.seven, ]
test_ds <- data[-id_instances.seven, ]
