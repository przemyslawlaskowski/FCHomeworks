#1. Write a script that repeatedly asks the user to enter an integer until a valid integer is provided. 
#Use exception handling to catch invalid inputs and prompt the user again.

def get_valid_integer():

    while True:
        try:
            user_input = input("Enter an integer: ")
            value = int(user_input)
            return value  
        except ValueError:
            print("Invalid input. Enter a valid integer.")

valid_integer = get_valid_integer()
print(f"You entered a valid integer: {valid_integer}")


#2. Create a script that prompts the user for their first name, last name, age, and email address. 
#Store this information in a dictionary and print it out in a formatted manner.

def get_user_info():
    first_name = input("Enter your first name: ")
    last_name = input("Enter your last name: ")
    age = input("Enter your age: ")
    email = input("Enter your email address: ")

    user_info = {
        "First Name": first_name,
        "Last Name": last_name,
        "Age": age,
        "Email": email
    }

    return user_info

def print_user_info(user_info):
    print("User Information:")
    print(f"First Name: {user_info['First Name']}")
    print(f"Last Name: {user_info['Last Name']}")
    print(f"Age: {user_info['Age']}")
    print(f"Email: {user_info['Email']}")

user_info = get_user_info()
print_user_info(user_info)
