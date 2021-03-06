customer= read.csv('customer.csv', header=TRUE)
head(customer)
str(customer)
customer = scale(customer[,-1])
hc = hclust(dist(customer, method="euclidean"), meth-od="ward.D2")
hc
plot(hc, hang = -0.01, cex = 0.7)
hc2 = hclust(dist(customer), method="single")
plot(hc2, hang = -0.01, cex = 0.7)
dv = diana(customer, metric = "euclidean")
summary(dv)
plot(dv)
install.packages("dendextend")
library(dendextend)
install.packages("margrittr")
library(magrittr)
dend = customer %>% dist %>% hclust %>% as.dendrogram
dend %>% plot(horiz=TRUE, main = "Horizontal Dendrogram")
fit = cutree(hc, k = 4)
fit
table(fit)
plot(hc)
rect.hclust(hc, k = 4 , border="red")
rect.hclust(hc, k = 4 , which =2, border="red")
dend %>% color_branches(k=4) %>% plot(horiz=TRUE, main = "Horizontal Dendrogram")
dend %>% rect.dendrogram(k=4,horiz=TRUE)
abline(v = heights_per_k.dendrogram(dend)["4"] + .1, lwd = 2, lty = 2, col = "blue")
set.seed(22)
fit = kmeans(customer, 4)
fit
barplot(t(fit$centers), beside = TRUE,xlab="cluster", ylab="value")
plot(customer, col = fit$cluster)
install.packages("cluster")
library(cluster)
clusplot(customer, fit$cluster, color=TRUE, shade=TRUE)
par(mfrow= c(1,2))
clusplot(customer, fit$cluster, color=TRUE, shade=TRUE)
rect(-0.7,-1.7, 2.2,-1.2, border = "orange", lwd=2)
clusplot(customer, fit$cluster, color = TRUE, xlim = c(-0.7,2.2), ylim = c(-1.7,-1.2))
install.packages("fpc")
library(fpc)
single_c =  hclust(dist(customer), method="single")
hc_single = cutree(single_c, k = 4)
complete_c =  hclust(dist(customer), method="complete")
hc_complete =  cutree(complete_c, k = 4)
set.seed(22)
km = kmeans(customer, 4)
cs = cluster.stats(dist(customer), km$cluster)
cs[c("within.cluster.ss","avg.silwidth")]
sapply(list(kmeans = km$cluster, hc_single = hc_single, hc_complete = hc_complete), function(c) clus-ter.stats(dist(customer), c)[c("within.cluster.ss","avg.silwidth")])
set.seed(22)
km = kmeans(customer, 4)
km$withinss
km$betweenss
set.seed(22)
km = kmeans(customer, 4)
kms = silhouette(km$cluster,dist(customer))
summary(kms)
plot(kms)
nk = 2:10
set.seed(22)
WSS = sapply(nk, function(k) {
  +     kmeans(customer, centers=k)$tot.withinss
   })
WSS
plot(nk, WSS, type="l", xlab= "number of k", ylab="within sum of squares")
SW = sapply(nk, function(k) {
  +   cluster.stats(dist(customer), kmeans(customer, cen-ters=k)$cluster)$avg.silwidth
   })
SW
plot(nk, SW, type="l", xlab="number of clusers", ylab="average silhouette width")
nk[which.max(SW)]
install.packages("mlbench")
library(mlbench)
install.packages("fpc")
library(fpc)
set.seed(2)
p = mlbench.cassini(500)
plot(p$x)
ds = dbscan(dist(p$x),0.2, 2, countmode=NULL, meth-od="dist")
ds
plot(ds, p$x)
y = matrix(0,nrow=3,ncol=2)
y[1,] = c(0,0)
y[2,] = c(0,-1.5)
y[3,] = c(1,1)
y
install.packages("mclust")
library(mclust)
mb = Mclust(customer)
plot(mb)
summary(mb)
install.packages("seriation")
library(seriation)
dissplot(dist(customer), labels=km$cluster, op-tions=list(main="Kmeans Clustering With k=4"))
complete_c =  hclust(dist(customer), method="complete")
hc_complete =  cutree(complete_c, k = 4)
dissplot(dist(customer), labels=hc_complete, op-tions=list(main="Hierarchical Clustering"))
install.packages("png")
library(png)
img2 = readPNG("handwriting.png", TRUE)
img3 = img2[,nrow(img2):1]
b = cbind(as.integer(which(img3 < -1) %% 28), which(img3 < -1) / 28)
plot(b, xlim=c(1,28), ylim=c(1,28))
set.seed(18)
fit = kmeans(b, 2)
plot(b, col=fit$cluster)
plot(b, col=fit$cluster,  xlim=c(1,28), ylim=c(1,28))
ds = dbscan(b, 2)
ds
plot(ds, b,  xlim=c(1,28), ylim=c(1,28))
