memo = {}

def waysToCover(n: int) -> int:  

    if n in memo:
        return memo[n]

    if n <= 0:
        return 0
    elif n == 1:
        return n

    steps  = waysToCover(n - 1) + waysToCover(n - 2) + waysToCover(n - 3)
    memo[n] = steps
    return steps


distance = int(input("Enter the Distance to Travel "))

answer = waysToCover(distance)

print(answer)
