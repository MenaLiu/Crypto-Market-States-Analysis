# 05_visualizations.R
# -------------------------------------------------------
# Step 1: Load Packages
# -------------------------------------------------------
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("scales")) install.packages("scales")
library(tidyverse)
library(ggplot2)
library(scales)

# -------------------------------------------------------
# Step 2: Load Data (with clusters & anomalies)
# -------------------------------------------------------
df_with_clusters <- read.csv("Dataset/df_with_anomalies.csv")

# -------------------------------------------------------
# Step 3: Violin Plots
# -------------------------------------------------------
# USD Price
ggplot(df_with_clusters, aes(x = as.factor(Cluster), y = USD_Price)) +
  geom_violin(trim = FALSE, fill = "lightblue", color = "black", alpha = 0.7) +
  geom_boxplot(width = 0.1, outlier.size = 1) +
  labs(title = "Violin Plot of USD Price by Clusters",
       x = "Cluster", y = "USD Price")

# Bitcoin Price
ggplot(df_with_clusters, aes(x = as.factor(Cluster), y = BTC_Price)) +
  geom_violin(trim = FALSE, fill = "lightblue", color = "black", alpha = 0.7) +
  geom_boxplot(width = 0.1, outlier.size = 1) +
  labs(title = "Violin Plot of Bitcoin Price by Clusters",
       x = "Cluster", y = "Bitcoin Price") +
  scale_y_continuous(labels = comma)

# -------------------------------------------------------
# Step 4: Scatter Plots
# -------------------------------------------------------
# USD Volume vs USD Price
ggplot(df_with_clusters, aes(x = USD_Price, y = USD_Volume, color = Cluster)) +
  geom_point() +
  labs(title = "USD Volume vs USD Price by Clusters",
       x = "USD Price", y = "USD Volume", color = "Cluster")

# Bitcoin Volume vs Bitcoin Price
ggplot(df_with_clusters, aes(x = BTC_Price, y = BTC_Volume, color = Cluster)) +
  geom_point() +
  labs(title = "Bitcoin Volume vs Bitcoin Price by Clusters",
       x = "Bitcoin Price", y = "Bitcoin Volume", color = "Cluster") +
  scale_y_continuous(labels = comma)

# Bitcoin Price vs USD Price
ggplot(df_with_clusters, aes(x = BTC_Price, y = USD_Price, color = Cluster)) +
  geom_point() +
  labs(title = "Bitcoin Price vs USD Price by Clusters",
       x = "Bitcoin Price", y = "USD Price", color = "Cluster")

# -------------------------------------------------------
# Step 5: Line Charts (Trends over Time)
# -------------------------------------------------------
# Bitcoin Price Trend
ggplot(df_with_clusters, aes(x = as.Date(Date), y = BTC_Price,
                             color = as.factor(Cluster), group = 1)) +
  geom_line(size = 1) +
  labs(title = "Bitcoin Price Trend Across Market Clusters",
       x = "Year", y = "Bitcoin Price", color = "Cluster") +
  theme_minimal()

# USD Price Trend
ggplot(df_with_clusters, aes(x = as.Date(Date), y = USD_Price,
                             color = as.factor(Cluster), group = 1)) +
  geom_line(size = 1) +
  labs(title = "USD Price Trend Across Market Clusters",
       x = "Year", y = "USD Price", color = "Cluster") +
  theme_minimal()
