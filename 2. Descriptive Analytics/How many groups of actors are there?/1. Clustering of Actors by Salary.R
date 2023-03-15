#########################################
#Data visualization of raw data
hist(df$Total.Gross)
hist(df$Num.Movies)
hist(df$Avg.Per.Movie, breaks = 20)
hist(df$Gross.of.No.1.Movie, breaks = 20)

pairs(~Total.Gross+Num.Movies+Avg.Per.Movie + Gross.of.No.1.Movie, data = df,
      main="Simple Scatterplot Matrix", pch=21, bg="red")

#########################################
#Preparing data for cluster analysis

row.names(df) <- df[[1]] #make the name the row.name
df <- df[c(-1,-5)] #Removing text of number 1 movie
df <- df[complete.cases(df),]
df <- scale(df, center = TRUE, scale = TRUE)#center and scale before clustering to ensure each variable is weighted equally in clustering exercise

##############################################
# Determine number of clusters
wss <- (nrow(df)-1)*sum(apply(df,2,var))
for (i in 2:10) wss[i] <- sum(kmeans(df, 
                                     centers=i)$withinss)

plot(1:10, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares", col = "red")

num.clust <- 5

##############################################
# Determine number of clusters

# K-Means Cluster Analysis
fit1 <- kmeans(df, num.clust) # 5 cluster solution
# get cluster means 
aggregate(df,by=list(fit1$cluster),FUN=mean)
# append cluster assignment
df <- data.frame(df, fit1$cluster)

##############################################
#Performing hCluster

# Ward Hierarchical Clustering
d <- dist(df, method = "euclidean") # distance matrix
fit2 <- hclust(d, method="ward.D") 
plot(fit2) # display dendogram
groups <- cutree(fit2, k=num.clust) # cut tree into 5 clusters
# draw dendogram with red borders around the 5 clusters 
rect.hclust(fit2, k=num.clust, border="red")
df <- data.frame(df, groups)

##############################################
#Cluster visualizations

pairs(~Total.Gross+Num.Movies+Avg.Per.Movie + Gross.of.No.1.Movie, data = df,
      main="Simple Scatterplot Matrix",pch = 21, bg = df$fit1.cluster)


##############################################
#Example stars

df <- df[order(-df$Total.Gross),]
temp <- df[which(df$fit1.cluster == 5),]

