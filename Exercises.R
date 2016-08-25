install.packages("ggplot2")
library(ggplot2)
source("http://bioconductor.org/biocLite.R") # run if necessary
biocLite("factoextra")# run if necessary
library(factoextra)
prad <- read.table('PRAD_normdata.txt', header=T, sep='\t', quote='"')
annot <- read.table('PRAD_SampleClass.txt', header=F, sep = '\t', quote = '"', stringsAsFactors = F)
names(annot) <- c('ID','Annotation')

#Histogram
hist(as.numeric(prad["EGFR",]),breaks=50,xlab="EGFR expression",ylab="Frequency (# of samples)",main="Histogram of EGFR expression")


# In general, for ggplot, want samples as rows and columns what you measured on those samples

pradt <- t(prad)

#Need to make a data frame
pradt <- as.data.frame(pradt)

## ggplot Histogram
ggplot(pradt, aes(EGFR)) + geom_histogram() +
  labs(title = "Histogram of EGFR Expression", 
       x = "EGFR Expression", y = "Frequency (# of Samples)")


#Scatter plot
plot(c(prad["EGFR",]),c(prad["IDH1",]),
     xlab="EGFR expression",ylab="IDH1 expression",
     main="EGFR versus IDH1",pch=20)

##add annotation
pradt$annot <- annot$Annotation

## ggplot scatter plot
ggplot(pradt, aes(EGFR, IDH1, color = annot)) +
  geom_point() + 
  labs(title = "EGFR vs IDH1", x = "EGFR Expression", y = "IDH1 Expression")


## Plotting PCA and Clustering Results with ggplot
# Log Transform
log.prad <- log(t(prad)[,])
log.prad[is.infinite(log.prad)] <- 0 # Remove -INF values

# PCA
# Use scale. and center to normalize
prad.pca <- prcomp(log.prad, center=T, scale.=T)

# Project to new coordinates
prad.project <- predict(prad.pca, log.prad)

# Get it ready for plotting
prad.project <- as.data.frame(prad.project)
prad.project$annot <- annot$Annotation


#Plot first PCA vs second PCA
ggplot(prad.project, aes(PC1, PC2, color = annot)) +
  geom_point() + 
  labs(title = "PC1 vs PC2", x = "PC1", y = "PC2")


##ggplot clustering and PCA

# Important to scale data before using any clustering method
scale.prad <- scale(t(prad))

# Use the `hcut` function from factoextra to perform hierarchical clustering
# k specifies the number of clusters, here, 2
hc.cut <- hcut(scale.prad, k = 2, hc_method = "ward.D")

# Add the clusters to our previous data for plotting
prad.project$clust <- hc.cut$cluster

graph <- ggplot(prad.project, aes(PC1, PC2, color = annot, shape = as.factor(clust))) +
  geom_point() + 
  labs(title = "PC1 vs PC2", x = "PC1", y = "PC2") +
  scale_shape_manual(name  = "Hierachical Cluster", values = c(1,15))


graph + scale_color_manual(name = "Tumor Type", values = c(9,3)) 












