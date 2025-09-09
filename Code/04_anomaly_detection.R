# 04_anomaly_detection.R
# -------------------------------------------------------
# Step 1: Load Packages
# -------------------------------------------------------
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("ggforce")) install.packages("ggforce")
library(tidyverse)
library(ggplot2)
library(ggforce)

# -------------------------------------------------------
# Step 2: Load Data
# -------------------------------------------------------
df_std <- readRDS("Dataset/df_std.rds")
merged_df <- read.csv("Dataset/df_cleaned.csv")

# -------------------------------------------------------
# Step 3: K-means Model (best k = 4)
# -------------------------------------------------------
set.seed(703)
best_k <- 4
best_model <- kmeans(df_std, centers = best_k)

# -------------------------------------------------------
# Step 4: Calculate Distances to Cluster Centers
# -------------------------------------------------------
distances <- numeric(nrow(df_std))
for (i in 1:nrow(df_std)) {
  cluster_id <- best_model$cluster[i]
  point <- as.numeric(df_std[i, ])
  center <- best_model$centers[cluster_id, ]
  distances[i] <- sqrt(sum((point - center)^2))
}

# Define anomaly threshold (3 * mean distance)
threshold <- 3 * mean(distances)

# -------------------------------------------------------
# Step 5: Label Anomalies
# -------------------------------------------------------
merged_df$Cluster <- factor(best_model$cluster)
merged_df$DistanceToCenter <- distances
merged_df$Anomaly <- ifelse(distances > threshold, "Anomaly", "Normal")

# Save labeled dataset
write.csv(merged_df, "Dataset/df_with_anomalies.csv", row.names = FALSE)

# -------------------------------------------------------
# Step 6: PCA Projection with Anomaly Highlight
# -------------------------------------------------------
pca_result <- prcomp(df_std, center = TRUE, scale. = FALSE)
df_pca <- as.data.frame(pca_result$x[, 1:2])
colnames(df_pca) <- c("PC1", "PC2")
df_pca$Cluster <- merged_df$Cluster
df_pca$Anomaly <- merged_df$Anomaly

ggplot(df_pca, aes(x = PC1, y = PC2, color = Anomaly, shape = Cluster)) +
  geom_point(size = 2, alpha = 0.8) +
  geom_mark_ellipse(aes(group = Cluster, fill = Cluster), alpha = 0.1, show.legend = FALSE) +
  scale_color_manual(values = c("Normal" = "grey", "Anomaly" = "red")) +
  labs(title = "Clusters with Anomalies Highlighted in PCA1 & PCA2",
       x = "Principal Component 1", y = "Principal Component 2") +
  theme_minimal()
