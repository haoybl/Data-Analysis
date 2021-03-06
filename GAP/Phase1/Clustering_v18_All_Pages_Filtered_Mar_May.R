# --------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------
#                                       ||     Bounce Rate    ||
# --------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------

setwd("C:/Yashwanth/GAP/1.Input_data/Data_1.4")

Bounce_Rate <- read.table(paste0(getwd(),"/Bounce_rate.csv"), 
                          header = TRUE, sep = ",", quote = "\"", dec = "." ,fill=TRUE, comment.char="", as.is=TRUE)

Avg_Time_On_Page <- read.table(paste0(getwd(),"/Avg_Time_On_Page.csv"), 
                               header = TRUE, sep = ",", quote = "\"", dec = "." ,fill=TRUE, comment.char="", as.is=TRUE)

Visits <- read.table(paste0(getwd(),"/Visits.csv"), 
                     header = TRUE, sep = ",", quote = "\"", dec = "." ,fill=TRUE, comment.char="", as.is=TRUE)

# --------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------
#                                       ||     Distribution : Last three months    ||
# --------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------

Bounce_Rate_Means <- data.frame(Pages=Bounce_Rate[,1],Means=rowMeans(Bounce_Rate[,-1]))
hist(Bounce_Rate_Means$Means,prob=T,xlab="Bounce Rate",main="Bounce Rate distribution")
curve(dnorm(x,mean=mean(Bounce_Rate_Means$Means),sd=sd(Bounce_Rate_Means$Means)),add=TRUE)

Avg_Time_On_Page_Means <- data.frame(Pages=Avg_Time_On_Page[,1],Means=rowMeans(Avg_Time_On_Page[,-1]))
hist(Avg_Time_On_Page_Means$Means,prob=T,xlab="Avg Time On Page",main="Avg TOP distribution")
curve(dnorm(x,mean=mean(Avg_Time_On_Page_Means$Means),sd=sd(Avg_Time_On_Page_Means$Means)),add=TRUE)

Visits_Means <- data.frame(Pages=Visits[,1],Means=rowMeans(Visits[,-1]))
hist(Visits_Means$Means,prob=T,xlab="Visits",main="Visits distribution")
curve(dnorm(x,mean=mean(Visits_Means$Means),sd=sd(Visits_Means$Means)),add=TRUE)
boxplot(Visits_Means$Means)
rm(list=ls(pattern="Means"))

# --------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------
#                                       || Merge data  ||
# --------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------

GAP_Pages <- data.frame(Bounce_Rate[,1],as.numeric(rowMeans(Bounce_Rate[,-1])),
                        as.numeric(rowMeans(Avg_Time_On_Page[,-1])),
                        as.numeric(rowMeans(Visits[,-1])),row.names=NULL)

names(GAP_Pages) <- c("Pages","Bounce_Rate","Avg_Time_On_Page","Visits")#"Prod_Page_Views","Page_Views"

# --------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------
#                                       || standardization of data  ||
# --------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------

library(clusterSim)
GAP_Pages_Std <- data.Normalization(GAP_Pages[,-1],type="n1")
rownames(GAP_Pages_Std) <- GAP_Pages[,1]

# --------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------
#                                       || Distance Matrix  ||
# --------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------

GAP_Pages_Dist <- data.frame(as.matrix(dist(GAP_Pages_Std,upper=TRUE)))
colnames(GAP_Pages_Dist) <- GAP_Pages[,1]
rownames(GAP_Pages_Dist) <- GAP_Pages[,1]
write.csv(GAP_Pages_Dist,"C:/Yashwanth/GAP/2.Distance_Matrix/10.All Pages filtered2/GAP_Pages_Filtered2_v1.csv")

# --------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------
