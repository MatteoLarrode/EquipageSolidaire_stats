# REPORT 2022 

#load packages & data ------------
library(tidyverse)
library(ggplot2)

orders_app <- read_csv("data/order.csv")

#data wrangling ---------------

#orders completed
orders_complete <- orders_app %>%
  filter(is_completed == 1)
  
orders_complete2 <- orders_complete%>%
  filter(infos != "Commande annuler par via le BO")


#eda -----------------

#orders by city
table(orders_complete$city)

#priority score
priroty_plot <- ggplot(data = orders_complete, x = )