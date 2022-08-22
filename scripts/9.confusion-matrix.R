#---------- Matriz de confusion
# ordenamos al conjunto de datos entrenado para que nos muestre primero
# que si se queda (1) y segundo que no (0)
ds_trained$real <- ordered(
    ds_trained$real,
    levels = c("1", "0")
)
ds_trained$prediccion <- ordered(
    ds_trained$prediccion,
    levels = c("1", "0")
)
glimpse(ds_trained)

# la matriz calculada seria el siguiente:
confusion_matrix <- table(
    ds_trained$real, ds_trained$prediccion,
    dnn = c("Real", "Predecido")
)

confusion_matrix
View(confusion_matrix)

round(prop.table(confusion_matrix, 2) * 100, 2)
# con esto podemos ver que los verdaderos positivos estan en un 77%
# mientras que los falsos positivos esta en un 59.2%
# lo cual nos quiere decir que nuestro modelo es lo suficientemente bueno
# como para predecir si va a estar o no 5 anos en la NBA en un poco mas de
# mitad de los casos

data.frame(table(ds_trained$real)) # para ver que tan sesgado estan los datos
# como se pudo apreciar, hay 256 registros que si iran 5 anos al NBA
# mientras otros 135 no lo haran
# Esto quiere decir, por tanto, que hay una diferencia de 121, lo cual
# nos dice que los datos estan un poco cesgados
