# Xom Data · Count digits in the password
# Problem: https://xomdata.com/practice/py-count-digits
# Solved: 2026-07-28

def count_digits(text):
    number = []
    for num in list(text):
        try:
            number.append(int(num))
        except:
            None
    return len(number)
