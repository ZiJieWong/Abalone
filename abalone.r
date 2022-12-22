#settings#

setwd("C:/Users/J/Documents/College/Master in Data Science/Sem 1/WQD7004 Programming in Data Science/Group assignment")

library(dplyr)
library(rlang)
library(tidyr)
library(readxl)
library(ggplot2)
library(gridExtra)
library(tidyverse)

#Read data#
baoyudata <- read.csv("abalone.csv")
head(baoyudata)
names(baoyudata)

###############
#cleaning data#
###############

#Remove all rows with NA data
baoyudata1 <- drop_na(baoyudata)
summary(baoyudata1)

#min data for height is 0, find the rows and decide what to do
baoyudata1[baoyudata1$height == 0,]

#since there is only 2 rows out of 4,000+ rows, impact towards the whole dataset is
#little, hence we decide to remove the 2 rows

#exclude data with negative or 0 values
baoyudata2 <- baoyudata1[!rowSums(baoyudata1 <= 0),]

#Purpose of this research is to simplify age estimating process for abalone,
#weighing the abalone's gut and drying their shells to weigh them is troublesome.
#Hence, we decide to drop both columns

#Drop columns viscera_wt and shell_wt
baoyudata3 = subset(baoyudata2, select = -c(viscera_wt, shell_wt))
head(baoyudata3)

baoyudat <- baoyudata3
summary(baoyudat)

#find number of categories in sex column
agg_sex <- baoyudat %>% group_by(sex) %>% summarise(total_count=n(), .groups = 'drop')
agg_sex

#group the data according to abalone sex
baoyu_m <- baoyudat %>% group_by(age) %>% filter(sex == "M") 
baoyu_f <- baoyudat %>% group_by(age) %>% filter(sex == "F")
baoyu_i <- baoyudat %>% group_by(age) %>% filter(sex == "I")

###Export into csv files
write.csv(baoyu_m, "C:/Users/J/Documents/College/Master in Data Science/Sem 1/WQD7004 Programming in Data Science/Group assignment/baoyu_m.csv", row.names = FALSE)
write.csv(baoyu_f, "C:/Users/J/Documents/College/Master in Data Science/Sem 1/WQD7004 Programming in Data Science/Group assignment/baoyu_f.csv", row.names = FALSE)
write.csv(baoyu_i, "C:/Users/J/Documents/College/Master in Data Science/Sem 1/WQD7004 Programming in Data Science/Group assignment/baoyu_i.csv", row.names = FALSE)
