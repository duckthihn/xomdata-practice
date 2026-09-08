# Xom Data · Sum of digits in the code
# Problem: https://xomdata.com/practice/py-digit-sum
# Solved: 2026-09-08

def digit_sum(number):

    string_num = str(number)

    total = 0

    for num in string_num:
        total += int(num)
    
    return total
