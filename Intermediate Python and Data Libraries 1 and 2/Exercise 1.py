# 1. Load the data into a pandas DataFrame

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


# Task 2: Check for missing values in the dataset

print("Sales Data Missing Values:\n", df_sales.isnull().sum())
print("\nEmployee Data Missing Values:\n", df_employee.isnull().sum())
print("\nWeather Data Missing Values:\n", df_weather.isnull().sum())
print("\nOrders Data Missing Values:\n", df_orders.isnull().sum())
print("\nFinancial Data Missing Values:\n", df_finance.isnull().sum())

# Task 3: Get basic summary statistics for numerical columns (mean, median, standard deviation, etc.)

print("\nSales Data Summary Statistics:\n", df_sales.describe())
print("\nEmployee Data Summary Statistics:\n", df_employee.describe())
print("\nWeather Data Summary Statistics:\n", df_weather.describe())
print("\nOrders Data Summary Statistics:\n", df_orders.describe())
print("\nFinancial Data Summary Statistics:\n", df_finance.describe())

# Task 4: Group by specific column and calculate sum/mean
# Group by 'Product' in sales and calculate sum of 'Quantity'

sales_grouped = df_sales.groupby('Product')['Quantity'].sum()
print("\nSum of Quantity by Product:\n", sales_grouped)

# Group by 'Department' in employee data and calculate mean of 'Salary'

employee_grouped = df_employee.groupby('Department')['Salary'].mean()
print("\nMean Salary by Department:\n", employee_grouped)

# Task 5: Filter rows based on conditions
# Filter rows where 'Price' > 150 in sales data

filtered_sales = df_sales[df_sales['Price'] > 150]
print("\nSales with Price > 150:\n", filtered_sales)

# Filter rows where 'Salary' < 60000 in employee data

filtered_employee = df_employee[df_employee['Salary'] < 60000]
print("\nEmployees with Salary < 60000:\n", filtered_employee)
