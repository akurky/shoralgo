from math import gcd
import numpy as np 
import random

def shorsalgorithm(N):
    if N < 1:
        printf("Invalid input. N must be integral, greater or equal to 1")

    outregw = np.ceil(np.log2(N))   # max number of qubits needed for output register
    inregw = 2 * outregw            # double size of input register 


    loop = 1
    while (loop):
        a = random.random(0,N)
        gcdaN = gcd(a,N)
        if gcdaN != 1:      # if N factors trivially...we're all done here
            break
    return


def quantumize():
    pass
def expmod(r,a,m):
    result = 1
    while a > 0:
        if a % 2 == 1:
            result = (result * r) % m
        a = np.floor(a / 2);
        r = (r * r) % m;
    return

