#Write code that takes a name and age as parameters and returns a formatted string such as "Hello, my name is {name} and I am {age} years old.". 
# Use both old-style % formatting and the newer format() method.

def format_string(name, age):
    old_style = "Hello, my name is %s and I am %d years old." % (name, age)
    new_style = "Hello, my name is {} and I am {} years old.".format(name, age)
    return old_style, new_style

name = "Przemek"
age = 33
old_format, new_format = format_string(name, age)


print("Old-style formatting:", old_format)
print("New-style formatting:", new_format)
