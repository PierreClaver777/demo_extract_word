
tab_dataframe <- function(tab) {
  
  indices_uniques <- unique(tab$doc_index)
  
  liste_dataframes <- list()
  i=0
  for (index in indices_uniques) {
    i=i+1
    df <- data.frame()
    for (cell_id_2 in 1:max((tab %>% filter(doc_index == index))$cell_id)) {
      subset_df <- tab %>% filter(doc_index == index, cell_id == cell_id_2) %>% select(text)
      if (nrow(df) == 0) (df = subset_df) else (df = cbind(df, subset_df)) 
    }
    liste_dataframes[[i]] <- df
  }
  return(liste_dataframes)
}