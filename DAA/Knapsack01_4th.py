def knapsack(values, weights, capacity):
    n = len(values)
    dp = [[0]*(capacity + 1) for _ in range(n + 1)]

    for i in range(1, n + 1):
        for w in range(1, capacity + 1):
            if weights[i-1] <= w:
                dp[i][w] = max(values[i-1] + dp[i-1][w - weights[i-1]], dp[i-1][w])
            else:
                dp[i][w] = dp[i-1][w]

    return dp[n][capacity]

# ---- Main ----
values = list(map(int, input("Enter values: ").split()))
weights = list(map(int, input("Enter weights: ").split()))
capacity = int(input("Enter capacity: "))

print("Maximum profit:", knapsack(values, weights, capacity))
