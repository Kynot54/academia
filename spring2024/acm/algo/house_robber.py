import random
from typing import List

random.seed(20)

def houseRobbing(arr: List[int]) -> int:

    if len(arr) == 1:
        return arr[0]

    for i in range(2, len(arr)):
        arr[i] = max(arr[i] + arr[i-2], arr[i-1])

    return arr[-1]

if __name__ == '__main__':
    arr = [int(x) for x in input().split()]
    res = houseRobbing(arr)
    print(res)

