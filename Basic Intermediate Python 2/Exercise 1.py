# Write a Python script with at least three functions. 
# Include comments and docstrings to explain each function, its parameters, and its return value.

def is_palindrome(s):
    """
    Checks if a given string is a palindrome
    Parameters:
    s (str): The string to check.

    Returns:
    bool: True if the string is a palindrome, False otherwise
    """
    s = s.replace(" ", "").lower()
    return s == s[::-1]

def multiply(a, b):
    """
    Multiplies two numbers together
    Parameters:
    a (int or float): The first number
    b (int or float): The second number

    Returns:
    int or float: The product of the two numbers
    """
    return a * b

def square(num):
    """
    Returns the square of a number
    Parameters:
    num (int or float): The number to be squared

    Returns:
    int or float: The square of the input number
    """
    return num ** 2

print(is_palindrome("Kajak"))
print(multiply(4, 5))
print(square(6))


# Create a script with intentional bugs.
# Add comments and temporary debug print statements to help identify and fix the issues.

def reverse_string(s):
    """
    Reverses the given string
    
    Parameters:
    s (str): The string to be reversed

    Returns:
    str: The reversed string
    """
    # Intentional bug: Incorrect slicing step
    # The slicing method used here (s[::-2]) skips every second character,
    # resulting in an incorrect reversed string. It should be s[::-1] for an proper reversal
    reversed_str = s[::-2]  
    print(f"Debug: Original string = {s}, Reversed string (with bug) = {reversed_str}") 
    return reversed_str

def count_characters(s):
    """
    Counts the number of characters in the given string
    
    Parameters:
    s (str): The string to be counted

    Returns:
    int: The number of characters in the string
    """
    # Intentional bug: Counting error
    # This adds 1 to the length of the string, which is incorrect
    character_count = len(s) + 1  # Intentional off-by-one error
    print(f"Debug: String = {s}, Character count (wrong) = {character_count}") 
    return character_count


def main():
    test_string = "Hello, Bayer!"
    
    # Test reverse_string function
    reversed_result = reverse_string(test_string)
    print(f"Reversed string: {reversed_result}")

    # Test count_characters function
    count_result = count_characters(test_string)
    print(f"Character count: {count_result}")

# The main function should be called to run the script
if __name__ == "__main__":
    main()
