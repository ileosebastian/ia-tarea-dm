# -------- Limpieza de datos
# Cambio de nombre de columnas
nba_players.clear <- nba_players %>%
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
  select(-X)

# eliminar registros nulos
nba_players.clear <- na.omit(nba_players.clear)
sapply(nba_players.clear, function(x) sum(is.na(x)))

# eliminar registros duplicados completos (fila n = fila m)
nba_players.clear <- unique(nba_players.clear)
