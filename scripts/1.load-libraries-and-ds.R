# ---------- Carga y preparacion de datos
# Cargar librerias
if (!require(tidyverse)) install.packages("tidyverse")
if (!require(dplyr)) install.packages("dplyr")
if (!require(caret)) install.packages("caret")
if (!require(pROC)) install.packages("pROC")
if (!require(cutpointr)) install.packages("cutpointr")

library("tidyverse")
library("dplyr")
library("caret") # para calcular metricas
library(pROC) # para las curvas ROC
library(cutpointr) # para calcular tasa FPR

# Cargar set de datos
nba_players <- read.csv("./nba-players_2.csv", sep = ";") # para windows
# nba_players <- read.csv("../nba-players_2.csv", sep = ";")

# pasar los datos como un data frame
nba_players <- as.data.frame(nba_players)
