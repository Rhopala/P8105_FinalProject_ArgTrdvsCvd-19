Volume 2021
================
Zoey Zhao
11/29/2021

------------------------------------------------------------------------

``` r
#Combine export data
export1 <-
  readxl::read_xls("./rawdata/monthly_exports_bytypes_2021.xls", 
                   sheet = 4,
                   range = "C44:C62",
                   col_names = "January")

export2 <-
  readxl::read_xls("./rawdata/monthly_exports_bytypes_2021.xls", 
                   sheet = 5,
                   range = "C44:C62",
                   col_names = "Feburary")

export3 <-
  readxl::read_xls("./rawdata/monthly_exports_bytypes_2021.xls", 
                   sheet = 6,
                   range = "C44:C62",
                   col_names = "March")

export4 <-
  readxl::read_xls("./rawdata/monthly_exports_bytypes_2021.xls", 
                   sheet = 7,
                   range = "C44:C62",
                   col_names = "April")

export5 <-
  readxl::read_xls("./rawdata/monthly_exports_bytypes_2021.xls", 
                   sheet = 8,
                   range = "C44:C62",
                   col_names = "May")

export6 <-
  readxl::read_xls("./rawdata/monthly_exports_bytypes_2021.xls", 
                   sheet = 9,
                   range = "C44:C62",
                   col_names = "June")

export7 <-
  readxl::read_xls("./rawdata/monthly_exports_bytypes_2021.xls", 
                   sheet = 10,
                   range = "C44:C62",
                   col_names = "July")

export8 <-
  readxl::read_xls("./rawdata/monthly_exports_bytypes_2021.xls", 
                   sheet = 11,
                   range = "C44:C62",
                   col_names = "August")

export9 <-
  readxl::read_xls("./rawdata/monthly_exports_bytypes_2021.xls", 
                   sheet = 12,
                   range = "C44:C62",
                   col_names = "September")

product_types <- data2021April <-
  readxl::read_xls("./rawdata/monthly_exports_bytypes_2021.xls", 
                   sheet = 12,
                   range = "A44:A62",
                   col_names = "product_types")
export2020_12 <-
  readxl::read_xls("./rawdata/monthly_exports_bytypes_2021.xls", 
                   sheet = 3,
                   range = "C44:C62",
                   col_names = "export_volume")%>%
  mutate(month = "December", product_types = pull(product_types, product_types), year = 2020)%>%
  select(product_types, month, export_volume, year)
  

export_volume_2021 <-
  bind_cols(product_types, export1, export2, export3, export4, export5, export6, export7, export8, export9)%>%
  pivot_longer(January:September, names_to = "month", values_to = "export_volume")%>%
  mutate(year = 2021)%>%
  bind_rows(export2020_12)%>%
  write.csv("./data/export_volumes_2021.csv", row.names = FALSE)
```

``` r
#combine import values
import1 <-
  readxl::read_xls("./rawdata/monthly_imports_bytypes_2021.xls", 
                   sheet = 4,
                   range = "C43:C55",
                   col_names = "January")

import2 <-
  readxl::read_xls("./rawdata/monthly_imports_bytypes_2021.xls", 
                   sheet = 5,
                   range = "C43:C55",
                   col_names = "Feburary")

import3 <-
  readxl::read_xls("./rawdata/monthly_imports_bytypes_2021.xls", 
                   sheet = 6,
                   range = "C43:C55",
                   col_names = "March")

import4 <-
  readxl::read_xls("./rawdata/monthly_imports_bytypes_2021.xls", 
                   sheet = 7,
                   range = "C43:C55",
                   col_names = "April")

import5 <-
  readxl::read_xls("./rawdata/monthly_imports_bytypes_2021.xls", 
                   sheet = 8,
                   range = "C43:C55",
                   col_names = "May")

import6 <-
  readxl::read_xls("./rawdata/monthly_imports_bytypes_2021.xls", 
                   sheet = 9,
                   range = "C43:C55",
                   col_names = "June")

import7 <-
  readxl::read_xls("./rawdata/monthly_imports_bytypes_2021.xls", 
                   sheet = 10,
                   range = "C43:C55",
                   col_names = "July")

import8 <-
  readxl::read_xls("./rawdata/monthly_imports_bytypes_2021.xls", 
                   sheet = 11,
                   range = "C43:C55",
                   col_names = "August")

import9 <-
  readxl::read_xls("./rawdata/monthly_imports_bytypes_2021.xls", 
                   sheet = 12,
                   range = "C43:C55",
                   col_names = "September")
types_import <- 
  readxl::read_xls("./rawdata/monthly_imports_bytypes_2021.xls", 
                   sheet = 12,
                   range = "A43:A55",
                   col_names = "product_types")

import2020_12 <-
  readxl::read_xls("./rawdata/monthly_exports_bytypes_2021.xls", 
                   sheet = 3,
                   range = "C43:C55",
                   col_names = "import_volume")%>%
  mutate(month = "December", product_types = pull(types_import, product_types), year = 2020)%>%
  select(product_types, month, import_volume, year)

import_volumes_2021 <-
  bind_cols(types_import, import1, import2, import3, import4, import5, import6, import7, import8, import9)%>%
  pivot_longer(January:September, names_to = "month", values_to = "import_volume")%>%
  mutate(year = 2021)%>%
  bind_rows(import2020_12)%>%
  write.csv("./data/import_volumes_2021.csv", row.names = FALSE)
```
