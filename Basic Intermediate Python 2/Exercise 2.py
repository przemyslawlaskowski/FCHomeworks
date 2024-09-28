# Write a function that takes a string and performs the following operations:
# - Convert the string to uppercase.
# - Replace all spaces with underscores.
# - Reverse the string.

def transform_string(s):
    # Convert the string to uppercase
    s = s.upper()
    # Replace all spaces with underscores
    s = s.replace(" ", "_")
    # Reverse the string
    s = s[::-1]
    return s

result = transform_string("Hello Mr. Bill Andreson!")
print(result) 
