library(tidyverse)
library(shiny)
library(DT)

shinyServer(function(input, output, session) {
  
  # import datas
  
  import_value_df = 
    read_csv("cleaned data/import_value_combined.csv") %>% 
    pivot_wider(
      names_from = product_type,
      values_from = import_value
    )
  
  export_value_df = 
    read_csv("cleaned data/export_value_combined.csv") %>% 
    pivot_wider(
      names_from = product_type,
      values_from = export_value
    )
  
  import_volume_df = 
    read_csv("cleaned data/import_volume_combined.csv") %>% 
    pivot_wider(
      names_from = product_type,
      values_from = import_volume
    )
  
  export_volume_df = 
    read_csv("cleaned data/export_volume_combined.csv") %>% 
    pivot_wider(
      names_from = product_type,
      values_from = export_volume
    )
  
  covid_df = 
    read_csv("cleaned data/covid_data_monthly.csv") %>% 
    mutate(
      month = month.name[month]
    )
  
  # render the tables
  output$dataset1 = DT::renderDataTable({
    import_value_df
  })
  
  # sorted columns are colored now because CSS are attached to them
  output$dataset2 = DT::renderDataTable({
    export_value_df
  })
  
  # customize the length drop-down menu; display 5 rows per page by default
  output$dataset3 = DT::renderDataTable({
    export_value_df
  })
  
  output$dataset4 = DT::renderDataTable({
    export_volume_df
  })
  
  output$dataset5 = DT::renderDataTable({
    covid_df
  })
})