# 1. Write a function sort_list(lst) that takes a list of numbers and returns it sorted in ascending order.
def sort_list(lst):
    return sorted(lst)

# 2. Write a function find_element(lst, target) that takes a list of numbers and a target element, and returns True if the element is in the list, or False if it is not.
def find_element(lst, target):
    return target in lst

# 3. Write a function sort_and_find(lst, target) that first sorts the list and then uses the find_element function to check if the target element is present in the sorted list. The function should return True or False.
def sort_and_find(lst, target):
    sorted_list = sort_list(lst)
    return f"{sorted_list} {find_element(sorted_list, target)}"

# 4. Write a function insert_element(lst, element) that adds a new element to the list and returns the updated list.
def insert_element(lst, element):
    lst.append(element)
    return lst

# 5. Write a function remove_element(lst, element) that removes the first occurrence of the element from the list and returns the updated list.
def remove_element(lst, element):
    if element in lst:
        lst.remove(element)
    return lst

# Examples
numbers = [5, 3, 8, 1, 49, 65, 2]
print("Sorted List:", sort_list(numbers))

print("Find 3:", find_element(numbers, 3))
print("Find 7:", find_element(numbers, 75))

print("Sort and Find 49:", sort_and_find(numbers, 49))
print("Insert 15:", insert_element(numbers, 15))

print("Remove 3:", remove_element(numbers, 3))
