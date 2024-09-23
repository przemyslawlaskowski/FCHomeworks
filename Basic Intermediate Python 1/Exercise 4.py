# Take a string expression (e.g., "3 + 5 * (2 - 8)") 
# and return the result of the expression using eval()

def evaluate_expression(expression):
    try:
        result = eval(expression)
        return result
    except (SyntaxError, NameError, ZeroDivisionError) as e:
        return f"Error: {e}"

expression = "3 + 5 * (2 - 8)"
result = evaluate_expression(expression)
print("Result:", result)
