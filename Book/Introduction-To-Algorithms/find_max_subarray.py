import sys
import random
import time


def timing(f):
    def wrap(*args):
        time1 = time.time()
        ret = f(*args)
        time2 = time.time()
        print '%s function took %0.3f ms' % (f.func_name, (time2-time1)*1000.0)
        return ret
    return wrap


def find_max_crossing_subarray(a, low, mid, high):
    max_left = 0
    max_right = 0
    left_sum = float('-Inf')
    sum = 0
    for i in range(mid, low - 1, -1):
        sum += a[i]
        if sum > left_sum:
            left_sum = sum
            max_left = i
    right_sum = float('-Inf')
    sum = 0
    for j in range(mid + 1, high + 1):
        sum += a[j]
        if sum > right_sum:
            right_sum = sum
            max_right = j
    return (max_left, max_right, left_sum + right_sum)


@timing
def find_maximum_subarray(a, low, high):
    if high - low < 400:
        return find_maximum_subarray_naive(a, low, high)
    else:
        mid = (low + high) / 2
        (left_low, left_high, left_sum) = \
            find_maximum_subarray(a, low, mid)
        (right_low, right_high, right_sum) = \
            find_maximum_subarray(a, mid + 1, high)
        (cross_low, cross_high, cross_sum) = \
            find_max_crossing_subarray(a, low, mid, high)

        if left_sum >= right_sum and left_sum >= cross_sum:
            return (left_low, left_high, left_sum)
        elif right_sum >= left_sum and right_sum >= cross_sum:
            return (right_low, right_high, right_sum)
        else:
            return (cross_low, cross_high, cross_sum)


@timing
def find_maximum_subarray_naive(a, low, high):
    sum = float('-Inf')
    for i in range(low, high + 1):
        current_sum = 0
        for j in range(i, high + 1):
            current_sum += a[j]
            if sum < current_sum:
                sum = current_sum
                left = i
                right = j
    return (left, right, sum)


count = int(sys.argv[1])
array = [random.randint(-100, 100) for i in xrange(count)]
print find_maximum_subarray(array, 0, count-1)
print find_maximum_subarray_naive(array, 0, count-1)


