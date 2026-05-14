library(tidyverse)
library(httr)  
library(rvest) 
library(janitor)
library(writexl)


#set url of site
myurl <- "https://finance.yahoo.com/quote/NYT/history?p=NYT"

#perform the GET call
website1 <- GET(myurl) 

#see how many tables this captures
tbls <- html_nodes(content(website1), "table")
length(tbls)

#grab the DATA inside the associated table
table1 <- html_table(tbls[[1]], fill=TRUE)

table1

# clean the column names
table1 <- table1 %>% 
  clean_names() 

table1


#export to Excel
write_xlsx(table1, "stocktable.xlsx")
