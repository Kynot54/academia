# Top - Down Dynamic Programming Apporach for the Fibonacci Sequence

memo = {}

def fibonacci(n, memo{}):
    if n in memo:
        return memo[n]
    if n <= 1:
        return n
    memo[n] = fibonacci(n - 1, memo) + fibonacci(n-2, memo)
    
    return memo[n]


number_of_iterations = input("Enter the Number of Fibonacci Sequence you want to compute: ")

answer = fibonacci(number_of_iterations, memo{})

