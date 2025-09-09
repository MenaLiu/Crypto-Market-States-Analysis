# Crypto-Market-States-Analysis

This is a data analytics project exploring the interaction between **Bitcoin** and the **US Dollar Index (DXY)**.  
The study applies **clustering** and **PCA** to uncover distinct market states, track their evolution, and evaluate hidden correlations.

## ✨ Project Overview
Cryptocurrency markets are volatile and influenced by global macroeconomic conditions.  
This project asks:
- Why compare Bitcoin and the US Dollar?  
- Can clustering reveal meaningful market regimes?  
- Do markets move together or diverge?  
- How can PCA help visualize complex financial data?  

## 🔧 Methods
- **Data Cleaning & Integration**: Combined Bitcoin trading data and USD index  
- **Clustering**: K-means clustering, silhouette score evaluation, optimal clusters = 4  
- **Dimensionality Reduction**: PCA to explain 87% of variance with 4 components  
- **Visualization**: Interactive Power BI dashboards and cluster-based trend analysis  

## 📊 Key Findings
- Identified **four distinct market states**:  
  1. *Bitcoin-Only Party* (BTC dominance)  
  2. *Calm Days* (low volatility, stable USD)  
  3. *Back to Dollars* (USD strength returns)  
  4. *Exit the Party* (BTC correction phase)  

- PCA clustering clearly separated bullish, bearish, and transitional regimes  
- Bitcoin and USD show periods of **inverse correlation**, but also **synchronized moves** during global shocks  

## 🚀 How to Run
1. Clone this repo  
2. Install R dependencies (`tidyverse`, `factoextra`, `cluster`)  
3. Run scripts in `Code/` folder for data cleaning, clustering, and PCA  
4. Open `Dashboard/Crypto-Market.pbix` in Power BI to explore the interactive visualizations  

## 📂 Repository Structure
