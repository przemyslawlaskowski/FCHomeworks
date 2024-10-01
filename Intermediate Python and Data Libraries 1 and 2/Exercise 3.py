import pandas as pd

# Sample dataset 1 - Sales Data
data_sales = {
    "Date": ["2023-01-01", "2023-01-02", "2023-01-03", "2023-01-04", "2023-01-05"],
    "Product": ["A", "B", "A", "C", "B"],
    "Quantity": [10, 5, 8, 6, 7],
    "Price": [100, 200, 100, 300, 200],
    "Customer_ID": [101, 102, 103, 104, 101],
}
df_sales = pd.DataFrame(data_sales)

# Sample dataset 2 - Employee Data
data_employee = {
    "Employee_ID": [1, 2, 3, 4, 5],
    "Name": ["Alice", "Bob", "Charlie", "David", "Eva"],
    "Department": ["HR", "IT", "HR", "Sales", "IT"],
    "Salary": [50000, 60000, 55000, 70000, 62000],
}
df_employee = pd.DataFrame(data_employee)

# Sample dataset 3 - Weather Data
data_weather = {
    "Date": ["2023-09-01", "2023-09-02", "2023-09-03", "2023-09-04", "2023-09-05"],
    "City": ["New York", "Los Angeles", "New York", "Chicago", "Los Angeles"],
    "Temperature": [80, 85, 82, 75, 88],
    "Rainfall": [0.1, 0.0, 0.2, 0.0, 0.0],
}
df_weather = pd.DataFrame(data_weather)

# Sample dataset 4 - Orders Data
data_orders = {
    "Order_ID": [1001, 1002, 1003, 1004, 1005],
    "Customer_ID": [101, 102, 103, 104, 105],
    "Order_Amount": [150, 200, 175, 220, 300],
    "Order_Date": [
        "2023-07-01",
        "2023-07-02",
        "2023-07-03",
        "2023-07-04",
        "2023-07-05",
    ],
}
df_orders = pd.DataFrame(data_orders)

# Sample dataset 5 - Financial Data
data_finance = {
    "Month": ["January", "February", "March", "April", "May"],
    "Income": [10000, 15000, 20000, 13000, 18000],
    "Expense": [5000, 7000, 9000, 4000, 8000],
    "Profit": [5000, 8000, 11000, 9000, 10000],
}
df_finance = pd.DataFrame(data_finance)

# 1. Merge two DataFrames on a common column (e.g., Customer_ID in sales and orders data).
merged_df = pd.merge(df_sales, df_orders, on='Customer_ID', how='outer')


# 2. Handle missing values that arise from a merge.
merged_df.fillna(0, inplace=True)
print("Merged DataFrame:")
print(merged_df)


# 3. Concatenate multiple DataFrames along rows or columns.
concat_rows = pd.concat([df_sales, df_orders], axis=0, ignore_index=True)
print("Concatenated along rows:")
print(concat_rows)

concat_columns = pd.concat([df_sales, df_orders], axis=1)
print("Concatenated along columns:")
print(concat_columns)


# 4. Use pivot_table to summarize data (e.g., showing total Quantity by Product and Date).
pivot_table = pd.pivot_table(df_sales, values='Quantity', index='Date', columns='Product', aggfunc='sum', fill_value=0)
print("Pivot Table (Total Quantity by Product and Date):")
print(pivot_table)
