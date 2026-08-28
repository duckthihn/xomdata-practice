# Xom Data · Average score by subject
# Problem: https://xomdata.com/practice/py-average
# Solved: 2026-08-28

def average_score(scores):
    a = sum(scores)
    b = len(scores)
    return a / b if b != 0 else 0
