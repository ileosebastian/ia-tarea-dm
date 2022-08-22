# ver el objeto en si
View(nba_players)
# Se puede observar una tabla con un gran numer de variables

# ver estructura del objeto
str(nba_players)
glimpse(nba_players)
# se puede observar 22 columnas y 1344 filas
# desde X que describe numero de la fila hasta target_5yrs que describe si
# el jugador para o no 5 anos en la NBA

# mostrar datos
head(nba_players)
tibble::as_tibble(nba_players)
attributes(nba_players)
names(nba_players)
tail(nba_players)
