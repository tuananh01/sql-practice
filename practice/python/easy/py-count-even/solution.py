# Xom Data · Count products with an even code
# Problem: https://xomdata.com/practice/py-count-even
# Solved: 2026-07-30

def count_even(numbers):
    count = 0
    for num in numbers:
        if num % 2 == 0:
            count += 1
    return count
