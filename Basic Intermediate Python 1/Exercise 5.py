#Write code that takes three boolean parameters and returns the result of the following expression: 
# A and (B or not C). Test the function with different values for A, B, and C.

def evaluate_expression(A, B, C):
    return A and (B or not C)

test_cases = [
    (True, True, True),
    (True, True, False),
    (True, False, True),
    (True, False, False),
    (False, True, True),
    (False, True, False),
    (False, False, True),
    (False, False, False),
]

for A, B, C in test_cases:
    result = evaluate_expression(A, B, C)
    print(f"A: {A}, B: {B}, C: {C}  Result: {result}")
