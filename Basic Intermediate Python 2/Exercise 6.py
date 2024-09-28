# 1. Filtering Elements: Write a function filter_even_numbers(lst) that takes a list of numbers and returns a list containing only even numbers.
def filter_even_numbers(lst):
    return [num for num in lst if num % 2 == 0]

# 2. Merging Lists: Write a function merge_lists(lst1, lst2) that takes two lists and returns them as a single merged list.
def merge_lists(lst1, lst2):
    return lst1 + lst2

# 3. Removing Duplicates: Write a function remove_duplicates(lst) that takes a list and returns a list with unique elements (no duplicates).
def remove_duplicates(lst):
    return list(set(lst))

# 4. Reversing a List: Write a function reverse_list(lst) that reverses the order of elements in a list and returns it.
def reverse_list(lst):
    return lst[::-1]

# 5. Finding the Maximum Element: Write a function find_max(lst) that finds and returns the largest element in a list.
def find_max(lst):
    return max(lst)

# Example:
numbers = [1, 52, 3, 4, 5, 6, 7, 8, 8, 5, 1, 55]
numbers2 = [9, 120, 115, 12, 4]

print("Filtered even numbers:", filter_even_numbers(numbers))
print("Merged lists:", merge_lists(numbers, numbers2))   
print("Removed duplicates:", remove_duplicates(numbers))    
print("Reversed list:", reverse_list(numbers))       
print("Maximum element:", find_max(numbers))      
