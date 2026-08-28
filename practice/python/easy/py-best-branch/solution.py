# Xom Data · Branch leading on revenue
# Problem: https://xomdata.com/practice/py-best-branch
# Solved: 2026-08-28

def best_branch(branches):
    if branches:
        max_key = max(branches, key=branches.get)
        return max_key
