#Write code that takes three integers and returns a message based on the following logic:
#    - Return `"All positive"` if all three integers are positive.
#    - Return `"Contains negative"` if at least one integer is negative.
#    - Return `"Mix of positive and negative"` if the integers include both positive and negative values.

def check_integers(a, b, c):
    
    if a > 0 and b > 0 and c > 0:
        return "All positive"
    elif a < 0 or b < 0 or c < 0:
        if a > 0 or b > 0 or c > 0:
            return "Mix of positive and negative"
        else:
            return "Contains negative"


print(check_integers(5, 7, 3))   
print(check_integers(-5, 7, 3)) 
print(check_integers(-5, -7, -3))


#Create code that demonstrates the short-circuit behavior of logical operators. 
#For example, use the `and` operator with a condition that evaluates to `False` and see if the second condition is evaluated.

def demonstrate_short_circuit(condition1, condition2):
  
  result = condition1 and condition2
  print(f"Condition 1: {condition1}")
  print(f"Condition 2: {condition2}")
  print(f"Result: {result}\n")


demonstrate_short_circuit(False, "This condition is never evaluated")
demonstrate_short_circuit(True, "This condition is evaluated")
