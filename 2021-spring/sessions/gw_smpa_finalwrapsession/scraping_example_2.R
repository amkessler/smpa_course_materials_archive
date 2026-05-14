library(tidyverse)
library(httr)  
library(rvest) 
library(janitor)
library(writexl)


#set url for transition list page
#using archived version here as it's subsequently changed
myurl <- "https://web.archive.org/web/20210114001001/https://buildbackbetter.gov/the-transition/agency-review-teams/"

#perform the GET call
website1 <- GET(myurl) 

#see how many tables this captures
tbls <- html_nodes(content(website1), "table")

num_tables <- length(tbls)
num_tables


#grab the titles of all tables
titles <- html_nodes(content(website1), "h2")

#capture just one
title1 <- print(html_text(titles)[[1]])

#grab the DATA inside the associated table
table1 <- html_table(tbls[[3]], fill=TRUE)
table1

#add the name of the table itself as a new column 
table1 <- table1 %>% 
  clean_names() %>% 
  mutate(
    agency = title1
  ) %>% 
  select(agency, everything())

table1
