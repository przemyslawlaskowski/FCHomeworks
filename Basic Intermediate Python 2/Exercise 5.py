# 1. Convert to Lowercase: Write a function to_lowercase(s) that converts all letters in a string to lowercase.
def to_lowercase(s):
    return s.lower()

# 2. Convert to Uppercase: Write a function to_uppercase(s) that converts all letters in a string to uppercase.
def to_uppercase(s):
    return s.upper()

# 3. Text Cleaning: Write a function clean_text(s) that removes all punctuation marks from the text and returns the cleaned text.
import string
def clean_text(s):
    return s.translate(str.maketrans('', '', string.punctuation))

# 4. Word Count: Write a function word_count(s) that counts the number of words in a string, where words are separated by spaces.
def word_count(s):
    return len(s.split(" "))

# 5. Replace Spaces with Underscores: Write a function replace_spaces(s) that replaces all spaces in a string with underscores.
def replace_spaces(s):
    return s.replace(' ', '_')

# Example:
test_string = "Hello, my name is Przemek"

print("Lowercase:", to_lowercase(test_string))
print("Uppercase:", to_uppercase(test_string))
print("Cleaned text:", clean_text(test_string))
print("Word count:", word_count(test_string))
print("Replace spaces:", replace_spaces(test_string))
