# -------- Limpieza de datos
# Cambio de nombre de columnas
nba_players_clear <- nba_players %>%
  rename(
    nombres = name,
    juegos_jug = gp,
    minutos_jug = min,
    puntos = pts,
    foles_campo_hechos = fgm,
    intentos_gol_campo = fga,
    porcen_goles_campo = fg,
    tres_pnts_hechos = X3p_made,
    intentos_tres_pnts = X3pa,
    porcen_tres_pnts = X3p,
    tiro_libre_hecho = ftm,
    tiro_libre_intentado = fta,
    porcen_tiro_libre = ft,
    rebotes_ofensivos = oreb,
    rebotes_defensivos = dreb,
    rebotes = reb,
    asistencias = ast,
    roba = stl,
    bloqueo = blk,
    perdidas_balon = tov,
    carrera_mas_de_5_anos = target_5yrs
  ) %>%
  select(-X) # usar todos los atributos menos X, es totalmente irrelevante

# eliminar registros nulos
nba_players_clear <- na.omit(nba_players_clear)
sapply(nba_players_clear, function(x) sum(is.na(x)))
# paso de 1344 registros a 1316 registros

# eliminar registros duplicados completos (fila n = fila m)
nba_players_clear <- unique(nba_players_clear)
# paso de 1316 registros a 1300 registros

# el dataset queda de la forma siguiente:
tibble::as_tibble(nba_players_clear)
