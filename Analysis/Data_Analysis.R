
# Importing, preparing and cleaning the data; for Data Section

library(plyr)
#setwd("C:\Users\aura7\Documents\SMU\Courses\Summer1\DoingDS_MSDS6306\week6\Unit6_Assignment\Rollingsales_queensv1")
bk <- read.csv("Data\\rollingsales_queens.csv",skip=4,header=TRUE)
bk$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","", bk$SALE.PRICE))
names(bk) <- tolower(names(bk)) # make all variable names lower case
## Get rid of leading digits
bk$gross.sqft <- as.numeric(gsub("[^[:digit:]]","", bk$gross.square.feet))
bk$land.sqft <- as.numeric(gsub("[^[:digit:]]","", bk$land.square.feet))
bk$year.built <- as.numeric(as.character(bk$year.built))
## keep only the actual sales
bk.sale <- bk[bk$sale.price.n!=0,]
## for now, let's look at 1-, 2-, and 3-family homes
bk.homes <- bk.sale[which(grepl("FAMILY",bk.sale$building.class.category)),]
## remove outliers that seem like they weren't actual sales
bk.homes$outliers <- (log10(bk.homes$sale.price.n) <=5) + 0
bk.homes <- bk.homes[which(bk.homes$outliers==0),]


plot(log10(bk.homes$gross.sqft),log10(bk.homes$sale.price.n))