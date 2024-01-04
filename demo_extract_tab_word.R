


# Lecture des dépendances -------------------------------------------------
library(officer)
library(tidyverse)
library(flattabler)
library(highcharter)

# Lecture du chemin d'accès -----------------------------------------------
setwd('C:/Users/DELL E 5480/Desktop/DemProject')
source("function_word.R")

# Ouverture du fichier Word -----------------------------------------------
file_word = read_docx("stat_water.docx")
file_word = docx_summary(file_word)

# Extraction de données tabulaires ----------------------------------------
file_word = file_word %>% filter(content_type == "table cell")
file_word = tab_dataframe(file_word) # Fonction qui extrait les tableaux et le stock dans les listes
file_word = file_word[[1]]

# Transformation de données -----------------------------------------------
file_word = pivot_table(file_word) %>% 
  flattabler::define_labels(n_col = 1,n_row = 2) %>% 
  fill_labels() %>% 
  fill_values() %>% 
  flattabler::remove_agg() %>% 
  flattabler::unpivot(na_rm = TRUE)
file_word = file_word[-2]
names(file_word) = c("indicateurs","annees", "valeurs")
file_word$valeurs = as.numeric(gsub(" ","", file_word$valeurs))


file_word %>% View()
# Visualisation de données ------------------------------------------------
highchart() %>% 
  hc_add_series(data = file_word,
                hcaes(x = annees, y = valeurs, group = indicateurs),
                type = "spline") %>% 
  hc_xAxis(categories = unique(file_word$annees)) %>% 
  hc_add_theme(hc_theme_google())

