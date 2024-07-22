def fibonacci(n):
    
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        # Resize the Table with Zeroes
        table = [0] * (n + 1)
        # Base Cases
        table[0] = 0
        table[1] = 1

        for i in range(2, n + 1):
            table[i]
