from sqlalchemy import create_engine
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.cm import ScalarMappable
from matplotlib.colors import Normalize
import seaborn as sns

engine = create_engine('mysql+pymysql://SQL_USERNAME:SQL_PASSWORD@localhost/supply_chain')

with engine.connect() as connection:
    try:
        query1 = '''
        SELECT ProductType, SUM(RevenueGenerated) AS TotalRevenue, SUM(NumberOfProductsSold) AS TotalSold
        FROM supply_chain_data
        GROUP BY ProductType
        '''
        df1 = pd.read_sql(query1, connection)

        sold_norm = Normalize(df1['TotalSold'].min(), df1['TotalSold'].max())
        scalar_map = ScalarMappable(norm=sold_norm, cmap='YlGnBu')

        fig, ax = plt.subplots(figsize=(10, 6))
        bars = ax.bar(df1['ProductType'], df1['TotalRevenue'], color=scalar_map.to_rgba(df1['TotalSold']))
        ax.set_xlabel('Product Type')
        ax.set_ylabel('Total Revenue')
        ax.set_title('Performance by Product Type')

        for bar, total_revenue, total_sold in zip(bars, df1['TotalRevenue'], df1['TotalSold']):
            label = f'${total_revenue:,.0f} / {int(total_sold)}'
            ax.text(bar.get_x() + bar.get_width() / 2, bar.get_height(), label, ha='center', va='bottom', fontsize=8)

        cbar = fig.colorbar(scalar_map, ax=ax, orientation='vertical')
        cbar.set_label('Number Of Products Sold')

        ax.set_xticklabels(df1['ProductType'], rotation=45)
        plt.tight_layout()
        plt.show()

        query2 = '''
        SELECT SupplierName, AVG(LeadTimes) AS AverageLeadTime, AVG(ManufacturingLeadTime) AS AverageManufacturingLeadTime, AVG(StockLevels) AS AverageStockLevel
        FROM supply_chain_data
        GROUP BY SupplierName
        '''
        df2 = pd.read_sql(query2, connection)

        stock_norm = Normalize(df2['AverageStockLevel'].min(), df2['AverageStockLevel'].max())
        scalar_map_stock = ScalarMappable(norm=stock_norm, cmap='YlGnBu')

        min_size, max_size = 7500, 75000
        sizes = (df2['AverageStockLevel'] - df2['AverageStockLevel'].min()) / (df2['AverageStockLevel'].max() - df2['AverageStockLevel'].min()) * (max_size - min_size) + min_size

        fig, ax = plt.subplots(figsize=(12, 8))
        scatter = ax.scatter(df2['AverageLeadTime'], df2['AverageManufacturingLeadTime'], c=scalar_map_stock.to_rgba(df2['AverageStockLevel']), s=sizes, alpha=0.75)
        ax.set_xlabel('Average Lead Time')
        ax.set_ylabel('Average Manufacturing Lead Time')
        ax.set_title('Supply Chain Efficiency by Supplier')
        cbar = fig.colorbar(scalar_map_stock, ax=ax, orientation='vertical')
        cbar.set_label('Average Stock Level')
        for i, txt in enumerate(df2['SupplierName']):
            ax.annotate(txt, (df2['AverageLeadTime'].iloc[i], df2['AverageManufacturingLeadTime'].iloc[i]), fontsize=8)
        plt.tight_layout()
        plt.show()

        query3 = '''
        SELECT ProductType, CustomerDemographics, SUM(NumberOfProductsSold) AS ProductsSold
        FROM supply_chain_data
        GROUP BY ProductType, CustomerDemographics
        ORDER BY ProductType, CustomerDemographics
        '''
        df3 = pd.read_sql(query3, connection)

        pivot_df = df3.pivot(index='ProductType', columns='CustomerDemographics', values='ProductsSold').fillna(0)

        fig, ax = plt.subplots(figsize=(12, 8))
        pivot_df.plot(kind='bar', stacked=True, colormap='YlGnBu', ax=ax)
        ax.set_xlabel('Product Type')
        ax.set_ylabel('Number of Products Sold')
        ax.set_title('Product Preference by Customer Demographics')
        plt.xticks(rotation=45)
        plt.legend(title='Customer Demographics')
        plt.tight_layout()
        plt.show()

        query4 = '''
        SELECT InspectionResults, DefectRates, RevenueGenerated, NumberOfProductsSold
        FROM supply_chain_data
        '''
        df4 = pd.read_sql(query4, connection)

        df4.dropna(inplace=True)

        sns.pairplot(df4, kind='scatter', diag_kind='kde', hue='InspectionResults', palette='YlGnBu')
        plt.suptitle('Product Quality and Return Rates Analysis', y=1.02)
        plt.show()

    except Exception as e:
        print('Error processing data:', e)
