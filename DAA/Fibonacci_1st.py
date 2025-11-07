# Recursive

step_count = 0

def fib_recursive(n):
    global step_count
    step_count += 1   # Count each function call as a step
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fib_recursive(n - 1) + fib_recursive(n - 2)

# Driver code
n = int(input("Enter n: "))
result = fib_recursive(n)
print(f"Fibonacci({n}) = {result}")
print(f"Step Count = {step_count}")
# Time Complexity: O(2^n)
# Space Complexity: O(n)


# Iterative
step_count = 0
def fib_iterative(n):
    global step_count
    if n == 0:
        step_count += 1
        return 0
    elif n == 1:
        step_count += 1
        return 1

    a, b = 0, 1
    for i in range(2, n + 1):
        step_count += 1   # Count each iteration as a step
        a, b = b, a + b
    return b
# Driver code
n = int(input("Enter n: "))
result = fib_iterative(n)
print(f"Fibonacci({n}) = {result}")
print(f"Step Count = {step_count}")
# Time Complexity: O(n)
# Space Complexity: O(1)