# 02_kmeans_clustering.R
# -------------------------------------------------------
# Step 1: Load Packages
# -------------------------------------------------------
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("cluster")) install.packages("cluster")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("gridExtra")) install.packages("gridExtra")
library(tidyverse)
library(cluster)
library(ggplot2)
library(gridExtra)

# -------------------------------------------------------
# Step 2: Load Preprocessed Data
# -------------------------------------------------------
# Use the standardized dataset from 01_data_cleaning.R
df_std <- readRDS("Dataset/df_std.rds")

# -------------------------------------------------------
# Step 3: Run K-means for Different Values of k
# -------------------------------------------------------
set.seed(703)  # reproducibility

fits <- list()
wcss_scores <- numeric()
silhouette_scores <- numeric()

for (k in 2:10) {
  model <- kmeans(df_std, centers = k)
  fits[[k]] <- model
  
  # WCSS
  wcss_scores[k] <- model$tot.withinss
  
  # Silhouette
  sil <- silhouette(model$cluster, dist(df_std))
  silhouette_scores[k] <- mean(sil[, 3])
}

# -------------------------------------------------------
# Step 4: Summarize Scores
# -------------------------------------------------------
scores_df <- data.frame(
  k = 2:10,
  WCSS = wcss_scores[2:10],
  Silhouette = silhouette_scores[2:10]
)

print(scores_df)

# Save results
write.csv(scores_df, "Dataset/cluster_metrics.csv", row.names = FALSE)

# -------------------------------------------------------
# Step 5: Visualization
# -------------------------------------------------------
wcss_plot <- ggplot(scores_df, aes(x = k, y = WCSS)) +
  geom_line() +
  geom_point() +
  labs(title = "Elbow Method (WCSS)", x = "Number of Clusters", y = "WCSS")

sil_plot <- ggplot(scores_df, aes(x = k, y = Silhouette)) +
  geom_line() +
  geom_point() +
  labs(title = "Silhouette Score", x = "Number of Clusters", y = "Avg Silhouette")

grid.arrange(wcss_plot, sil_plot, ncol = 2)
