# Write code that takes a list of mixed data types (integers, floats, strings, etc.) and converts all elements to integers. 
# Handle any errors that may arise during conversion (e.g., invalid string formats).

def convert_to_integers(mixed_list):
    result = []
    for item in mixed_list:
        try:
            integer_value = int(float(item))
            result.append(integer_value)
        except (ValueError, TypeError):
            result.append(None)
    return result

example_list = [1, 2.5, "3", "4.7", "hello", [1, 2], {"a": 1}, True, False]
converted_list = convert_to_integers(example_list)
print(converted_list)
