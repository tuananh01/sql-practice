# Xom Data · Count students above the benchmark
# Problem: https://xomdata.com/practice/py-above-threshold
# Solved: 2026-07-26

def count_above(numbers, threshold):
    count = 0
    for number in numbers:
        if number > threshold:
            count += 1
    return count
