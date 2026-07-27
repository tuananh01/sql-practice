# Xom Data · Average score by subject
# Problem: https://xomdata.com/practice/py-average
# Solved: 2026-07-27

def average_score(scores):
    result = 0
    for score in scores:
        result += score
    if len(scores) == 0:
        result == 0
    else: 
        result = round((result/len(scores)),2)
    return result
