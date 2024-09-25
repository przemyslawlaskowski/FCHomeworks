#Write a script that prints a multiplication table for numbers 1 through 10.
#Use nested `for` loops to generate the table and format the output neatly.

def print_multiplication_table():

  for row in range(1, 11):
    for col in range(1, 11):
      print(f"{row * col:3}", end=" ")
    print()

print_multiplication_table()
