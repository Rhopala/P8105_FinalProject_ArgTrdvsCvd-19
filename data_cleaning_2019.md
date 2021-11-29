data\_cleaning\_2019
================
AnMei Chen
11/28/2021

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──

    ## ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
    ## ✓ tibble  3.1.5     ✓ dplyr   1.0.7
    ## ✓ tidyr   1.1.3     ✓ stringr 1.4.0
    ## ✓ readr   2.0.1     ✓ forcats 0.5.1

    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(readxl)
```

## 2019 export by values and volumes

``` r
exports_volume_df = 
  read_excel("data/2019 Exports.xlsx",sheet = "Volumes", range = "A3:M22") %>% 
  janitor::clean_names() %>% 
  pivot_longer(
    january:december,
    names_to = "Month",
    values_to = "Export_Volume"
  ) %>% 
  rename("Item" = "items")

exports_values_df = 
  read_excel("data/2019 Exports.xlsx",sheet = "Values", range = "A10:M36") %>% 
  janitor::clean_names() %>% 
  pivot_longer(
    january:december,
    names_to = "Month",
    values_to = "Export_Value"
  ) %>% 
  rename("Item" = "items")
```

## 2019 imports by values and volumes

``` r
imports_volume_df =
  read_excel("data/2019 imports.xlsx",sheet = "Volumes", range = "A3:M16") %>% 
  janitor::clean_names() %>% 
  pivot_longer(
    january:december,
    names_to = "Month",
    values_to = "Import_Volume"
  ) %>% 
  mutate(
    items = recode(items, "Wine 4/" = "Wine", "Malt beverages 4/" = "Malt beverages")
  ) %>% 
  rename("Item" = "items")

imports_values_df =
  read_excel("data/2019 imports.xlsx",sheet = "Values", range = "A10:M38") %>% 
  janitor::clean_names() %>% 
  pivot_longer(
    january:december,
    names_to = "Month",
    values_to = "Import_Value"
  ) %>% 
  rename("Item" = "items")
```

## 2019 Top 10 U.S. export markets for soybeans, corn, wheat, and cotton, by volume

``` r
soybeans_df =
  read_excel("data/2019 Top 10 exports.xlsx",sheet = "2019", range = "A7:M17") %>% 
  janitor::clean_names() %>% 
  pivot_longer(
    january:december,
    names_to = "Month",
    values_to = "Export_Volume"
  ) %>% 
  add_column("Commodity" = "soybean")

corn_df =
  read_excel("data/2019 Top 10 exports.xlsx",sheet = "2019", range = "A20:M30") %>% 
  janitor::clean_names() %>% 
  pivot_longer(
    january:december,
    names_to = "Month",
    values_to = "Export_Volume"
  ) %>% 
  add_column("Commodity" = "corn")

wheat_df =
  read_excel("data/2019 Top 10 exports.xlsx",sheet = "2019", range = "A33:M43") %>% 
  janitor::clean_names() %>% 
  pivot_longer(
    january:december,
    names_to = "Month",
    values_to = "Export_Volume"
  ) %>% 
  add_column("Commodity" = "Wheat,unmilled")

wheat_df =
  read_excel("data/2019 Top 10 exports.xlsx",sheet = "2019", range = "A46:M56") %>% 
  janitor::clean_names() %>% 
  pivot_longer(
    january:december,
    names_to = "Month",
    values_to = "Export_Volume"
  ) %>% 
  add_column("Commodity" = "Cotton,ex linters")

top_10_exports_df = 
  rbind(soybeans_df,corn_df,wheat_df,wheat_df) %>% 
  relocate(Commodity,.before = Month) %>% 
  rename("Export_Country" = "country") %>% 
  mutate(
    Export_Country = recode(Export_Country, "European Union-28 3/" = "European Union-28")
  )
```

\#\#2019 Top 10 sources of U.S. imports of fruits and vegetables, by
value

``` r
fresh_fruits_df =
  read_excel("data/2019 Top 10 imports.xlsx",sheet = "2019", range = "A8:M18") %>% 
  janitor::clean_names() %>% 
  pivot_longer(
    january:december,
    names_to = "Month",
    values_to = "Import_Value"
  ) %>% 
  add_column("Commodity" = "Fruits, fresh or frozensoybean")

prepared_fruits_df =
  read_excel("data/2019 Top 10 imports.xlsx",sheet = "2019", range = "A21:M31") %>% 
  janitor::clean_names() %>% 
  pivot_longer(
    january:december,
    names_to = "Month",
    values_to = "Import_Value"
  ) %>% 
  add_column("Commodity" = "Fruits, prepared or preserved")

fresh_vege_df =
  read_excel("data/2019 Top 10 imports.xlsx",sheet = "2019", range = "A34:M44") %>% 
  janitor::clean_names() %>% 
  pivot_longer(
    january:december,
    names_to = "Month",
    values_to = "Import_Value"
  ) %>% 
  add_column("Commodity" = "Vegetables, fresh or frozen")

prepared_vege_df =
  read_excel("data/2019 Top 10 imports.xlsx",sheet = "2019", range = "A47:M57") %>% 
  janitor::clean_names() %>% 
  pivot_longer(
    january:december,
    names_to = "Month",
    values_to = "Import_Value"
  ) %>% 
  add_column("Commodity" = "Vegetables, prepared or preserved")

top_10_imports_df = 
  rbind(fresh_fruits_df,prepared_fruits_df,fresh_vege_df,prepared_vege_df) %>% 
  relocate(Commodity,.before = Month) %>% 
  rename("Import_Country" = "import_country") %>%
  mutate(
    Import_Country = recode(Import_Country, "European Union-28 3/" = "European Union-28")
  ) 
```
