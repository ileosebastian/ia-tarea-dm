#---------- Carga y preparacion de datos
# Cargar librerias
if (!require(tidyverse)) install.packages("tidyverse")
if (!require(dplyr)) install.packages("dplyr")
if (!require(stats)) install.packages("stats")
if (!require(caret)) install.packages("caret")
if (!require(gmodels)) install.packages("gmodels")
if (!require(ROCR)) install.packages("ROCR")

library("tidyverse")
library("dplyr")
library("stats")
library("stringr")
library("caret")
library("gmodels")
library("ROCR")

# Cargar set de datos
nba_players <- read.csv("../nba-players_2.csv", sep = ";")

nba_players <- as.data.frame(nba_players)
