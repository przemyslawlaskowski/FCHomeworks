from datetime import datetime, timedelta
# 1. Write a function format_date(date_string) that takes a date in the format "YYYY-MM-DD" and returns it in the format "DD-MM-YYYY".
def format_date(date_string):
    date = datetime.strptime(date_string, "%Y-%m-%d")
    return date.strftime("%d-%m-%Y")

# 2. Write a function add_days(date_string, days) that takes a date in the format "YYYY-MM-DD" and a number of days, and returns a new date shifted by the given number of days.
def add_days(date_string, days):
    date = datetime.strptime(date_string, "%Y-%m-%d")
    new_date = date + timedelta(days=days)
    return new_date.strftime("%Y-%m-%d")

# 3. Write a function days_between_dates(date1, date2) that takes two dates in the format "YYYY-MM-DD" and returns the number of days between them.
def days_between_dates(date1, date2):
    date1 = datetime.strptime(date1, "%Y-%m-%d")
    date2 = datetime.strptime(date2, "%Y-%m-%d")
    return abs((date2 - date1).days)

# 4. Write a function weeks_between_dates(date1, date2) that returns the number of weeks (rounded down) between two dates.
def weeks_between_dates(date1, date2):
    return days_between_dates(date1, date2) // 7

# 5. Write a function day_of_week(date_string) that takes a date in the format "YYYY-MM-DD" and returns the name of the day of the week for that date.
def day_of_week(date_string):
    date = datetime.strptime(date_string, "%Y-%m-%d")
    return date.strftime("%A")

# Example
print("Formatted Date:", format_date("2023-09-28")) 
print("Add Days:", add_days("2024-05-08", 5))     
print("Days Between:", days_between_dates("2023-04-28", "2023-10-03"))  
print("Weeks Between:", weeks_between_dates("2022-12-28", "2023-10-03"))  
print("Day of the Week:", day_of_week("2021-01-08"))
