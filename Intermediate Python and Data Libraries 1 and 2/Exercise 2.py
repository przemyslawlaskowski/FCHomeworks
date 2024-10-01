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

# Task 1: Remove duplicate rows based on a specific column (Customer_ID)
df_sales_no_duplicates = df_sales.drop_duplicates(subset="Customer_ID")

print("Sales Data after removing duplicates based on Customer_ID:\n", df_sales_no_duplicates)

# Task 2: Fill missing values with mean, median, or mode
# Add missing value for demonstration purposes

df_sales.loc[2, 'Quantity'] = None

# Fill missing values in 'Quantity' column with the mean

df_sales_filled_mean = df_sales.copy()
df_sales_filled_mean['Quantity'].fillna(df_sales['Quantity'].mean(), inplace=True)
print("\nSales Data after filling missing values with mean in 'Quantity':\n", df_sales_filled_mean)

# Fill missing values in 'Quantity' column with the median

df_sales_filled_median = df_sales.copy()
df_sales_filled_median['Quantity'].fillna(df_sales['Quantity'].median(), inplace=True)
print("\nSales Data after filling missing values with median in 'Quantity':\n", df_sales_filled_median)

# Task 3: Convert the 'Date' column to datetime format

df_sales['Date'] = pd.to_datetime(df_sales['Date'])
print("\nSales Data with 'Date' column converted to datetime:\n", df_sales)

# Task 4: Rename columns for easier readability (e.g., rename Employee_ID to ID)

df_employee_renamed = df_employee.rename(columns={"Employee_ID": "ID"})
print("\nEmployee Data with renamed column 'Employee_ID' to 'ID':\n", df_employee_renamed)

# Task 5: Sort the DataFrame by a specific column (e.g., Quantity or Salary)
# Sorting df_sales by 'Quantity'

df_sales_sorted = df_sales.sort_values(by='Quantity', ascending=False)
print("\nSales Data sorted by 'Quantity':\n", df_sales_sorted)

# Sorting df_employee by 'Salary'

df_employee_sorted = df_employee.sort_values(by='Salary', ascending=True)
print("\nEmployee Data sorted by 'Salary':\n", df_employee_sorted)
