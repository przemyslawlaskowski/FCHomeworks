import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

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

# Task 1: Plot a bar chart showing total sales (Quantity * Price) by Product
df_sales['Total_Sales'] = df_sales['Quantity'] * df_sales['Price']
total_sales_by_product = df_sales.groupby('Product')['Total_Sales'].sum()

plt.figure(figsize=(8, 6))
sns.barplot(x=total_sales_by_product.index, y=total_sales_by_product.values, palette='viridis')
plt.title('Total Sales by Product')
plt.xlabel('Product')
plt.ylabel('Total Sales (Quantity * Price)')
plt.show()

# Task 2: Create a line plot showing the trend of Temperature over time
df_weather['Date'] = pd.to_datetime(df_weather['Date'])

plt.figure(figsize=(8, 6))
sns.lineplot(x='Date', y='Temperature', data=df_weather, marker='o')
plt.title('Temperature Trend Over Time')
plt.xlabel('Date')
plt.ylabel('Temperature')
plt.xticks(rotation=45)
plt.show()

# Task 3: Plot a scatter plot between Salary and Employee_ID
plt.figure(figsize=(8, 6))
sns.scatterplot(x='Employee_ID', y='Salary', data=df_employee)
plt.title('Salary vs Employee ID')
plt.xlabel('Employee ID')
plt.ylabel('Salary')
plt.show()

# Task 4: Plot a histogram to visualize the distribution of Order_Amount
plt.figure(figsize=(8, 6))
sns.histplot(df_orders['Order_Amount'], bins=5, kde=True)
plt.title('Distribution of Order Amount')
plt.xlabel('Order Amount')
plt.ylabel('Frequency')
plt.show()

# Task 5: Plot a pie chart to show the percentage distribution of Department
department_distribution = df_employee['Department'].value_counts()

plt.figure(figsize=(8, 6))
plt.pie(department_distribution, labels=department_distribution.index, autopct='%1.1f%%', startangle=90, colors=sns.color_palette("Set2"))
plt.title('Percentage Distribution of Departments')
plt.show()
