#Write a script that prints a multiplication table for numbers 1 through 10.
#Use nested `for` loops to generate the table and format the output neatly.

def print_multiplication_table():

  for row in range(1, 11):
    for col in range(1, 11):
      print(f"{row * col:3}", end=" ")
    print()

print_multiplication_table()

# Write code that finds and prints all prime numbers between 1 and 100. 
# Use a for loop with an if statement to check for prime numbers.

for num in range(2, 101):
    is_prime = True
    for i in range(2, int(num ** 0.5) + 1):
        if num % i == 0:
            is_prime = False
            break
    if is_prime:
        print(num)

# Write a list comprehension to generate a list of squares for even numbers between 1 and 20.
# Print the resulting list.

squares = [x**2 for x in range(1, 21) if x % 2 == 0]
print(squares)
