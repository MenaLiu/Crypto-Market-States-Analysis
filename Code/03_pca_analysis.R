# 03_pca_analysis.R
# -------------------------------------------------------
# Step 1: Load Packages
# -------------------------------------------------------
if (!require("ggplot2")) install.packages("ggplot2")
library(ggplot2)

# -------------------------------------------------------
# Step 2: Load Standardized Data
# -------------------------------------------------------
df_std <- readRDS("Dataset/df_std.rds")

# -------------------------------------------------------
# Step 3: Run PCA
# -------------------------------------------------------
pca_result <- prcomp(df_std, center = TRUE, scale. = FALSE)

# Explained variance
explained_variance <- summary(pca_result)$importance[2, ]
print(explained_variance)

# Save explained variance
pca_variance_df <- data.frame(
  Principal_Component = paste0("PC", seq_along(explained_variance)),
  Proportion_of_Variance = explained_variance
)
write.csv(pca_variance_df, "Dataset/pca_explained_variance.csv", row.names = FALSE)

# -------------------------------------------------------
# Step 4: Variance Explained Plot
# -------------------------------------------------------
barplot(explained_variance,
        main = "Variance Explained by Each Principal Component",
        xlab = "Principal Components",
        ylab = "Proportion of Variance")

# -------------------------------------------------------
# Step 5: PCA Scatter Plot with Clusters
# -------------------------------------------------------
# Use best_k = 4 (from clustering results)
best_k <- 4
# Load k-means model (re-run quickly here)
set.seed(703)
kmeans_model <- kmeans(df_std, centers = best_k)

df_pca <- data.frame(pca_result$x[, 1:2])
colnames(df_pca) <- c("PC1", "PC2")
df_pca$Cluster <- as.factor(kmeans_model$cluster)

ggplot(df_pca, aes(x = PC1, y = PC2, color = Cluster)) +
  geom_point(alpha = 0.7, size = 2) +
  labs(title = "Clusters Visualized in PCA1 & PCA2",
       x = "Principal Component 1",
       y = "Principal Component 2") +
  theme_minimal()
