import pandas as pd

# Sample dataset - Sales Data
data_sales = {
    "Date": ["2023-01-01", "2023-01-02", "2023-01-03", "2023-01-04", "2023-01-05"],
    "Product": ["A", "B", "A", "C", "B"],
    "Quantity": [10, 5, 8, 6, 7],
    "Price": [100, 200, 100, 300, 200],
    "Customer_ID": [101, 102, 103, 104, 101],
}
df_sales = pd.DataFrame(data_sales)

# Sample dataset - Financial Data
data_finance = {
    "Month": ["January", "February", "March", "April", "May"],
    "Income": [10000, 15000, 20000, 13000, 18000],
    "Expense": [5000, 7000, 9000, 4000, 8000],
}
df_finance = pd.DataFrame(data_finance)

# Task 1: Apply custom function to calculate profit margin
def profit_margin(row):
    return (row['Price'] - 50) / row['Price']

df_sales['Profit_Margin'] = df_sales.apply(profit_margin, axis=1)
print("Sales DataFrame with Profit Margin:")
print(df_sales)


# Task 2. Group by 'Product' and perform multiple aggregations
grouped_data = df_sales.groupby('Product').agg({
    'Quantity': ['sum', 'mean'], 
    'Price': ['sum', 'mean']
})
print("Grouped Data with Aggregations:")
print(grouped_data)


# Task3. Create new column 'Total_Sales' as Quantity * Price
df_sales['Total_Sales'] = df_sales['Quantity'] * df_sales['Price']
print("Sales DataFrame with Total Sales:")
print(df_sales)


# Task 4. Reshape using melt and pivot
melted_df = df_sales.melt(id_vars=['Date', 'Product'], value_vars=['Quantity', 'Price'], var_name='Metric', value_name='Value')
print("Melted DataFrame:")
print(melted_df)

pivoted_df = melted_df.pivot(index='Date', columns='Metric', values='Value')
print("Pivoted DataFrame:")
print(pivoted_df)


# Task 5. Rolling and Expanding Mean for Income
df_finance['Rolling_Income_Mean'] = df_finance['Income'].rolling(window=3).mean()
df_finance['Expanding_Income_Mean'] = df_finance['Income'].expanding().mean()
print("Finance DataFrame with Rolling and Expanding Mean of Income:")
print(df_finance)
