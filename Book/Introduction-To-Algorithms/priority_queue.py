def heap_maximum(A):
    return A[0]


def heap_extract_max(A):
    if A.heap_size < 1:
        raise IndexError(A.heap_size)
    max = A[0]
    A[0] = A[A.heap_size - 1]
    A.heap_size = A.heap_size - 1
    max_heapify(A, 0);
    return max


def heap_increase_key(A, i, key):
    if key < A[i]:
        raise IndexError(i)
    A[i] = key
    while i > 1 and A[parent(i)] < A[i]:
        temp = A[i]
        A[i] = A[parent(i)]
        A[parent(i)] = temp
        i = parent(i)
