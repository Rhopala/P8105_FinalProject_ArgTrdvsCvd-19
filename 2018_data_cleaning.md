Data Cleaning 2018
================
Xinyi Zhou

## 2018 export

``` r
exports_value = 
  read_excel("./rawdata/export2018.xlsx", range = "A3:M28", col_names = c("product_type", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")) %>% 
  pivot_longer(
    January:December,
    names_to = "month",
    values_to = "export_value"
  ) %>%
  mutate(year = "2018")%>%
  select(product_type, year, everything()) %>%
  write.csv("./data/export_value_2018.csv", row.names = FALSE)

exports_volume= 
  read_excel("./rawdata/export2018.xlsx", range = "A32:M50", col_names = c("product_type", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")) %>% 
  pivot_longer(
    January:December,
    names_to = "month",
    values_to = "export_volume"
  ) %>%
  mutate(year = "2018")%>%
  select(product_type, year, everything()) %>%
  write.csv("./data/export_volume_2018.csv", row.names = FALSE)
```

## 2018 import

``` r
imports_value = 
  read_excel("./rawdata/import2018.xlsx", range = "A3:M30", col_names = c("product_type", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")) %>% 
  pivot_longer(
    January:December,
    names_to = "month",
    values_to = "import_value"
  ) %>%
  mutate(year = "2018")%>%
  select(product_type, year, everything()) %>%
  write.csv("./data/import_value_2018.csv", row.names = FALSE)

imports_volume= 
  read_excel("./rawdata/import2018.xlsx", range = "A34:M46", col_names = c("product_type", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")) %>% 
  pivot_longer(
    January:December,
    names_to = "month",
    values_to = "import_volume"
  ) %>%
  mutate(year = "2018")%>%
  select(product_type, year, everything()) %>%
  write.csv("./data/import_volume_2018.csv", row.names = FALSE)
```

## 2018 Top 10 U.S. export markets for soybeans, corn, wheat, and cotton, by volume

``` r
read_file_soybeans = function(x) {
  read_excel("./rawdata/exportcmd2018.xls",sheet = x, range = "A6:E16", col_names = c("country", "a", "b", "c", "d")) %>%
    select(country, d) %>%
    mutate(month = x)
}

output_soybeans = vector("list", length =12)

for (i in 4:15) {
  output_soybeans[[i]] = read_file_soybeans(i)
}

soybeans = output_soybeans %>% 
  bind_rows() %>%
  rename(volume = d) %>%
  mutate(year = "2018", 
         product = "Soybeans",
         month = replace(month, month == 4, "January"),
         month = replace(month, month == 5, "February"),
         month = replace(month, month == 6, "March"),
         month = replace(month, month == 7, "April"),
         month = replace(month, month == 8, "May"),
         month = replace(month, month == 9, "June"),
         month = replace(month, month == 10, "July"),
         month = replace(month, month == 11, "August"),
         month = replace(month, month == 12, "September"),
         month = replace(month, month == 13, "October"),
         month = replace(month, month == 14, "November"),
         month = replace(month, month == 15, "December")
         )
```

``` r
read_file_wheat = function(x) {
  read_excel("./rawdata/exportcmd2018.xls",sheet = x, range = "A18:E28", col_names = c("country", "a", "b", "c", "d")) %>%
    select(country, d) %>%
    mutate(month = x)
}

output_wheat = vector("list", length =12)

for (i in 4:15) {
  output_wheat[[i]] = read_file_wheat(i)
}

wheat = output_wheat %>% 
  bind_rows() %>%
  rename(volume = d) %>%
  mutate(year = "2018", 
         product = "Wheat",
         month = replace(month, month == 4, "January"),
         month = replace(month, month == 5, "February"),
         month = replace(month, month == 6, "March"),
         month = replace(month, month == 7, "April"),
         month = replace(month, month == 8, "May"),
         month = replace(month, month == 9, "June"),
         month = replace(month, month == 10, "July"),
         month = replace(month, month == 11, "August"),
         month = replace(month, month == 12, "September"),
         month = replace(month, month == 13, "October"),
         month = replace(month, month == 14, "November"),
         month = replace(month, month == 15, "December")
         )
```

``` r
read_file_corn = function(x) {
  read_excel("./rawdata/exportcmd2018.xls",sheet = x, range = "A30:E40", col_names = c("country", "a", "b", "c", "d")) %>%
    select(country, d) %>%
    mutate(month = x)
}

output_corn = vector("list", length =12)

for (i in 4:15) {
  output_corn[[i]] = read_file_corn(i)
}

corn = output_corn %>% 
  bind_rows() %>%
  rename(volume = d) %>%
  mutate(year = "2018", 
         product = "Corn",
         month = replace(month, month == 4, "January"),
         month = replace(month, month == 5, "February"),
         month = replace(month, month == 6, "March"),
         month = replace(month, month == 7, "April"),
         month = replace(month, month == 8, "May"),
         month = replace(month, month == 9, "June"),
         month = replace(month, month == 10, "July"),
         month = replace(month, month == 11, "August"),
         month = replace(month, month == 12, "September"),
         month = replace(month, month == 13, "October"),
         month = replace(month, month == 14, "November"),
         month = replace(month, month == 15, "December")
         )
```

``` r
read_file_cotton = function(x) {
  read_excel("./rawdata/exportcmd2018.xls",sheet = x, range = "A42:E52", col_names = c("country", "a", "b", "c", "d")) %>%
    select(country, d) %>%
    mutate(month = x)
}

output_cotton = vector("list", length =12)

for (i in 4:15) {
  output_cotton[[i]] = read_file_cotton(i)
}

cotton = output_cotton %>% 
  bind_rows() %>%
  rename(volume = d) %>%
  mutate(year = "2018", 
         product = "Cotton",
         month = replace(month, month == 4, "January"),
         month = replace(month, month == 5, "February"),
         month = replace(month, month == 6, "March"),
         month = replace(month, month == 7, "April"),
         month = replace(month, month == 8, "May"),
         month = replace(month, month == 9, "June"),
         month = replace(month, month == 10, "July"),
         month = replace(month, month == 11, "August"),
         month = replace(month, month == 12, "September"),
         month = replace(month, month == 13, "October"),
         month = replace(month, month == 14, "November"),
         month = replace(month, month == 15, "December")
         )
```

``` r
rbind(soybeans, wheat, corn, cotton) %>%
  select(product, country, year, month, volume) %>%
  write.csv("./data/top10_export_volume_2018.csv", row.names = FALSE)
```

\#\#2018 Top 10 sources of U.S. imports of fruits and vegetables, by
value

``` r
read_file_fruits_f = function(x) {
  read_excel("./rawdata/importcmd2018.xls",sheet = x, range = "A6:E16", col_names = c("country", "a", "b", "c", "d")) %>%
    select(country, d) %>%
    mutate(month = x)
}

output_fruits_f = vector("list", length =12)

for (i in 4:15) {
  output_fruits_f[[i]] = read_file_fruits_f(i)
}

fruits_f = output_fruits_f %>% 
  bind_rows() %>%
  rename(value = d) %>%
  mutate(year = "2018", 
         product = "Fruits, fresh or frozen",
         month = replace(month, month == 4, "January"),
         month = replace(month, month == 5, "February"),
         month = replace(month, month == 6, "March"),
         month = replace(month, month == 7, "April"),
         month = replace(month, month == 8, "May"),
         month = replace(month, month == 9, "June"),
         month = replace(month, month == 10, "July"),
         month = replace(month, month == 11, "August"),
         month = replace(month, month == 12, "September"),
         month = replace(month, month == 13, "October"),
         month = replace(month, month == 14, "November"),
         month = replace(month, month == 15, "December")
         )
```

``` r
read_file_fruits_p = function(x) {
  read_excel("./rawdata/importcmd2018.xls",sheet = x, range = "A18:E28", col_names = c("country", "a", "b", "c", "d")) %>%
    select(country, d) %>%
    mutate(month = x)
}

output_fruits_p = vector("list", length =12)

for (i in 4:15) {
  output_fruits_p[[i]] = read_file_fruits_p(i)
}

fruits_p = output_fruits_p %>% 
  bind_rows() %>%
  rename(value = d) %>%
  mutate(year = "2018", 
         product = "Fruits, prepared or preserved",
         month = replace(month, month == 4, "January"),
         month = replace(month, month == 5, "February"),
         month = replace(month, month == 6, "March"),
         month = replace(month, month == 7, "April"),
         month = replace(month, month == 8, "May"),
         month = replace(month, month == 9, "June"),
         month = replace(month, month == 10, "July"),
         month = replace(month, month == 11, "August"),
         month = replace(month, month == 12, "September"),
         month = replace(month, month == 13, "October"),
         month = replace(month, month == 14, "November"),
         month = replace(month, month == 15, "December")
         )
```

``` r
read_file_veg_f = function(x) {
  read_excel("./rawdata/importcmd2018.xls",sheet = x, range = "A30:E40", col_names = c("country", "a", "b", "c", "d")) %>%
    select(country, d) %>%
    mutate(month = x)
}

output_veg_f = vector("list", length =12)

for (i in 4:15) {
  output_veg_f[[i]] = read_file_veg_f(i)
}

veg_f = output_veg_f %>% 
  bind_rows() %>%
  rename(value = d) %>%
  mutate(year = "2018", 
         product = "Vegetables, fresh or frozen",
         month = replace(month, month == 4, "January"),
         month = replace(month, month == 5, "February"),
         month = replace(month, month == 6, "March"),
         month = replace(month, month == 7, "April"),
         month = replace(month, month == 8, "May"),
         month = replace(month, month == 9, "June"),
         month = replace(month, month == 10, "July"),
         month = replace(month, month == 11, "August"),
         month = replace(month, month == 12, "September"),
         month = replace(month, month == 13, "October"),
         month = replace(month, month == 14, "November"),
         month = replace(month, month == 15, "December")
         )
```

``` r
read_file_veg_p = function(x) {
  read_excel("./rawdata/importcmd2018.xls",sheet = x, range = "A42:E52", col_names = c("country", "a", "b", "c", "d")) %>%
    select(country, d) %>%
    mutate(month = x)
}

output_veg_p = vector("list", length =12)

for (i in 4:15) {
  output_veg_p[[i]] = read_file_veg_p(i)
}

veg_p = output_veg_p %>% 
  bind_rows() %>%
  rename(value = d) %>%
  mutate(year = "2018", 
         product = "Vegetables, prepared or preserved",
         month = replace(month, month == 4, "January"),
         month = replace(month, month == 5, "February"),
         month = replace(month, month == 6, "March"),
         month = replace(month, month == 7, "April"),
         month = replace(month, month == 8, "May"),
         month = replace(month, month == 9, "June"),
         month = replace(month, month == 10, "July"),
         month = replace(month, month == 11, "August"),
         month = replace(month, month == 12, "September"),
         month = replace(month, month == 13, "October"),
         month = replace(month, month == 14, "November"),
         month = replace(month, month == 15, "December")
         )
```

``` r
rbind(fruits_f, fruits_p, veg_f, veg_p) %>%
  select(product, country, year, month, value) %>%
  write.csv("./data/top10_import_value_2018.csv", row.names = FALSE)
```
