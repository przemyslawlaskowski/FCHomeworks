# 1. Most Common Word: Write a function most_common_word(s) that takes a string and returns the most frequently occurring word in that string.
from collections import Counter

def most_common_word(s):
    words = s.split()
    word_counts = Counter(words)
    return word_counts.most_common(1)[0][0]

# 2. Longest Word Length: Write a function longest_word_length(s) that takes a string and returns the length of the longest word in that string.
def longest_word_length(s):
    words = s.split()
    return len(max(words, key=len))

# 3. Split Words: Write a function split_words(s) that takes a string and returns a list of words, where each word is separated by a space.
def split_words(s):
    return s.split()

# 4. Letter Count: Write a function letter_count(s) that counts the occurrences of each character in a string and returns a dictionary with these counts.
def letter_count(s):
    letter_dict = {}
    for char in s:
        if char in letter_dict:
            letter_dict[char] += 1
        else:
            letter_dict[char] = 1
    return letter_dict

# 5. Removing a Word: Write a function remove_word(s, word) that removes all occurrences of a specified word from the text and returns the updated text.
def remove_word(s, word):
    return ' '.join([w for w in s.split() if w != word]) 

# Example:
test_string = "Bayer is great and Bayer is health and Bayer is science"

print("Most common word:", most_common_word(test_string))
print("Longest word length:", longest_word_length(test_string))
print("Split words:", split_words(test_string))
print("Letter count:", letter_count(test_string))
print("Remove word:", remove_word(test_string, "Bayer"))
