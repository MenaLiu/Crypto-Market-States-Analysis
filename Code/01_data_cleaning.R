# 01_data_cleaning.R
# ---------------------------------------------
# Step 1: Load Packages
# ---------------------------------------------
if (!require("tidyverse")) install.packages("tidyverse")
library(tidyverse)

# ---------------------------------------------
# Step 2: Load Dataset
# ---------------------------------------------
# Assumes the cleaned dataset is stored in Dataset/Cleaned Data.csv
merged_df <- read.csv("Dataset/Cleaned Data.csv")

# ---------------------------------------------
# Step 3: Outlier Treatment Function
# ---------------------------------------------
replace_outliers_with_median <- function(x) {
  Q1 <- quantile(x, 0.25, na.rm = TRUE)
  Q3 <- quantile(x, 0.75, na.rm = TRUE)
  IQR <- Q3 - Q1
  med <- median(x, na.rm = TRUE)
  x[x < (Q1 - 1.5 * IQR) | x > (Q3 + 1.5 * IQR)] <- med
  return(x)
}

# ---------------------------------------------
# Step 4: Apply Outlier Cleaning
# ---------------------------------------------
merged_df <- merged_df %>%
  mutate(across(c(BTC_Price, BTC_Volume, BTC_Range, BTC_High, BTC_Low,
                  USD_Price, USD_Volume, USD_Range, USD_High, USD_Low),
                replace_outliers_with_median))

# ---------------------------------------------
# Step 5: Standardize Data
# ---------------------------------------------
df_std <- as.data.frame(scale(merged_df))

# ---------------------------------------------
# Step 6: Save Processed Data for Later Steps
# ---------------------------------------------
saveRDS(df_std, "Dataset/df_std.rds")
write.csv(merged_df, "Dataset/df_cleaned.csv", row.names = FALSE)
