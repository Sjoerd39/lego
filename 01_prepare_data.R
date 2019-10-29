library(tidyverse)

fp <- list.files(path = "data/", full.names = TRUE, pattern="*.csv")
names <- list.files(path = "data/", pattern="*.csv") %>% 
  str_replace_all(".csv", "")

list <- lapply(fp, read.csv)
names(list) <- names

lego_df <- list$parts %>% 
  full_join(list$inventory_parts, by = c("part_num")) %>% 
  full_join(list$part_categories %>% rename(part_name_cat = name), by = c("part_cat_id" = "id")) %>% 
  full_join(list$colors %>% rename(col_name = name), by = c("color_id" = "id")) %>% 
  full_join(list$inventories, by = c("inventory_id" = "id")) %>% 
  full_join(list$inventory_sets %>% rename(set_quantity = quantity, inv_set_num = set_num), by = c("inventory_id")) %>% 
  full_join(list$sets %>%  rename(set_name = name), by = c("set_num")) %>% 
  full_join(list$themes %>% rename(theme_name = name), by = c("theme_id" = "id"))

lego_2018 <- lego_df %>% 
  group_by(year)
  
  
## https://www.kaggle.com/nateaff/finding-lego-color-themes-with-topic-models
## colour plot
## TF-IDF
##