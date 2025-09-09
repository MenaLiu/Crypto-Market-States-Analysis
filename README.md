# Crypto-Market-States-Analysis

This is a data analytics project exploring the interaction between **Bitcoin** and the **US Dollar Index (DXY)**.  
The study applies **clustering** and **PCA** to uncover distinct market states, track their evolution, and evaluate hidden correlations.

## ✨ Problem Statement
Cryptocurrency markets are volatile and strongly influenced by macroeconomic factors.  
This project investigates:
- Why compare Bitcoin and the US Dollar?  
- Can clustering reveal meaningful market regimes?  
- Do markets move together or diverge?  
- How can PCA help visualize complex financial data?

## 📂 Dataset
This project uses two original raw datasets:  
- **Cryptocurrency_Trading_Dataset.csv** → Bitcoin trading data (price, volume, volatility, etc.)  
- **US Dollar Index Futures Historical Data.csv** → USD Index futures data  

These two datasets were merged and cleaned into a single dataset:  
- **Cleaned Data.csv** → Integrated dataset containing aligned BTC and USD features, used as the starting point for all analyses.  

To keep the workflow reproducible, all R scripts begin from `Cleaned Data.csv`.  
The raw datasets are included for reference.

## 🔧 Methods
- **Data Cleaning**: Outlier replacement with median, standardization  
- **Clustering**: K-means (k=2–10), evaluated with WCSS & Silhouette score  
- **Dimensionality Reduction**: PCA to capture variance and visualize clusters  
- **Anomaly Detection**: Distance-to-centroid approach to flag unusual days  
- **Visualization**: ggplot2 (R) and Power BI dashboards  

## 📊 Key Findings
- Identified **four distinct market states**:  
  1. *Bitcoin-Only Party* (BTC dominance)  
  2. *Calm Days* (low volatility, stable USD)  
  3. *Back to Dollars* (USD strength returns)  
  4. *Exit the Party* (BTC correction phase)  

- PCA showed that the top 4 components explain **87% of total variance**  
- Bitcoin and USD showed periods of **inverse correlation**, but also **synchronized trends** during global shocks  
- Anomalies aligned with **extreme BTC price spikes**  

## 🖼️ Dashboard Screenshots
### Introduction
![](Power%20BI%20Dashboard/Introduction.png)

### Methodology
![](Power%20BI%20Dashboard/Methodology.png)

### Cluster Analysis
![](Power%20BI%20Dashboard/Cluster%20Analysis%2001.png)  
![](Power%20BI%20Dashboard/Cluster%20Analysis%2002.png)
