Two panel spaghetti plot
================

We will first clean the data of U.S. agricultural trade value by month
for 2018-2020, and calculate the average monthly import values before
(2018-2019) and after (2020-2021) Covid-19 as well as average monthly
export values before and after Covid-19. An ideal visualization will be
a two-panel (export value/import value) spaghetti plot with month of a
year as x-axis, average export/import value as y-axis, and colored by
before/after Covid-19.

``` r
export_value = read_excel("./data/export_value_combined.xlsx") %>%
  mutate(type = "export") %>%
  rename(value = export_value)
import_value = read_excel("./data/import_value_combined.xlsx") %>%
  mutate(type = "import") %>%
  rename(value = import_value)

value = rbind(export_value, import_value) %>%
  mutate(year = as.character(year),
         month = recode(month, "Feburary" = "February"),
         month = as.factor(ordered(month, levels = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")))) %>%
  group_by(year, month, type) %>%
  mutate(monthly_total = sum(value),
         covid_19 = ifelse(year %in% c("2018", "2019"), "before", "after")) %>% 
  group_by(covid_19, month, type) %>%
  mutate(avg_value = mean(monthly_total)) 

value %>%
  ggplot(aes(x = month, y = avg_value, color = covid_19, group = covid_19)) +
  geom_line() +
  labs(y = "average value", title = "spaghetti plot of the average monthly export or import values before and after Covid-19") +
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5, hjust = 0.5)) +
  facet_grid(. ~ type)
```

![](two_panel_spaghetti_plot_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

``` r
value %>%
  ggplot(aes(x = month, y = monthly_total, color = year, group = year)) +
  geom_line() +
  labs(y = "average value", title = "spaghetti plot of the average monthly export or import values for each year") +
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5, hjust = 0.5)) +
  facet_grid(. ~ type)
```

![](two_panel_spaghetti_plot_files/figure-gfm/unnamed-chunk-1-2.png)<!-- -->

## spaghetti plot of the average monthly export or import volumes before and after Covid-19

``` r
export_volume = 
  read_excel("./data/export_volume_combined.xlsx") %>%
  mutate(type = "export") %>%
  rename(volume = export_volume)
import_volume = 
  read_excel("./data/import_volume_combined.xlsx") %>%
  mutate(type = "import") %>%
  rename(volume = import_volume)

volume = rbind(export_volume, import_volume) %>%
  mutate(year = as.character(year),
         month = recode(month, "Feburary" = "February"),
         month = as.factor(ordered(month, levels = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")))) %>%
  group_by(year, month, type) %>%
  mutate(monthly_total = sum(volume),
         covid_19 = ifelse(year %in% c("2018", "2019"), "before", "after")) %>% 
  group_by(covid_19, month, type) %>%
  mutate(avg_volume = mean(monthly_total)) 

im_volume_plot = volume %>%
  filter(type == "import") %>%
  ggplot(aes(x = month, y = avg_volume, color = covid_19, group = covid_19)) +
  geom_line() +
  labs(y = "", title = "import") +
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5, hjust = 0.5))

ex_volume_plot = volume %>%
  filter(type == "export") %>%
  ggplot(aes(x = month, y = avg_volume, color = covid_19, group = covid_19)) +
  geom_line() +
  labs(y = "average volume", title = "export") +
  theme(legend.position = "none") +
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5, hjust = 0.5))

ex_volume_plot + im_volume_plot 
```

![](two_panel_spaghetti_plot_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

``` r
volume %>%
  ggplot(aes(x = month, y = monthly_total, color = year, group = year)) +
  geom_line() +
  labs(y = "average volume", title = "spaghetti plot of the average monthly export or import volumes for each year") +
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5, hjust = 0.5)) +
  facet_grid(. ~ type)
```

![](two_panel_spaghetti_plot_files/figure-gfm/unnamed-chunk-2-2.png)<!-- -->

## spaghetti plot of the average monthly export or import volumes for each year

``` r
im_volume_plot_byyear = volume %>%
  filter(type == "import") %>%
  ggplot(aes(x = month, y = monthly_total, color = year, group = year)) +
  geom_line() +
  labs(y = "", title = "import") +
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5, hjust = 0.5))

ex_volume_plot_byyear = volume %>%
  filter(type == "export") %>%
  ggplot(aes(x = month, y = monthly_total, color = year, group = year)) +
  geom_line() +
  labs(y = "average volume", title = "export") +
  theme(legend.position = "none") +
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5, hjust = 0.5))

ex_volume_plot_byyear + im_volume_plot_byyear
```

![](two_panel_spaghetti_plot_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->
