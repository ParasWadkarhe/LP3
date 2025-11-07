# Fractional Knapsack using Greedy Method (with user input)

class Item:
    def __init__(self, value, weight):
        self.value = value
        self.weight = weight

def fractional_knapsack(items, capacity):
    # Step 1: Sort items by value/weight ratio in descending order
    items.sort(key=lambda x: x.value / x.weight, reverse=True)

    total_value = 0.0

    # Step 2: Pick items greedily
    for item in items:
        if capacity >= item.weight:
            capacity -= item.weight
            total_value += item.value
        else:
            fraction = capacity / item.weight
            total_value += item.value * fraction
            break  # Knapsack is full

    return total_value

# ----------------------------
# Taking user input
# ----------------------------
n = int(input("Enter number of items: "))

items = []
for i in range(n):
    value = float(input(f"Enter value of item {i+1}: "))
    weight = float(input(f"Enter weight of item {i+1}: "))
    items.append(Item(value, weight))

capacity = float(input("Enter knapsack capacity: "))

# ----------------------------
# Compute result
# ----------------------------
max_value = fractional_knapsack(items, capacity)
print("\nMaximum value in Knapsack =", max_value)




# without user input, the example usage would look like this:

class Item:
    def __init__(self, value, weight):
        self.value = value
        self.weight = weight

def fractional_knapsack(items, capacity):
    # Step 1: Calculate value/weight ratio and sort items (descending)
    items.sort(key=lambda x: x.value / x.weight, reverse=True)

    total_value = 0.0  # total profit
    for item in items:
        if capacity >= item.weight:
            # take the whole item
            capacity -= item.weight
            total_value += item.value
        else:
            # take fractional part
            fraction = capacity / item.weight
            total_value += item.value * fraction
            break  # knapsack full

    return total_value

# Example usage
items = [
    Item(60, 10),
    Item(100, 20),
    Item(120, 30)
]

capacity = 50
max_value = fractional_knapsack(items, capacity)
print("Maximum value in Knapsack =", max_value)
