# Write a Python script that demonstrates the difference between local and global variables. 
# Define a global variable and a function that modifies it. Explain the output of the script.

x = 14

def modify_variable():
    global x
    x = 25
    y = 33
    print("Inside function, x:", x)
    print("Inside function, y:", y)

modify_variable()
print("Outside function, x:", x)
