    HEAP-MINIMUM(A)
    return A[1]
    
    HEAP-EXTRACT-MIN(A)
    if A.heap_size < 1
        error "heap underflow"
    min = A[1]
    A[1] = A[A.heap_size]
    A.heap_size = A.heap_size - 1
    MIN-HEAPIFY(A, 1)
    return max
    
    HEAP-DECREASE-KEY(A, i, key)
    if key < A[i]
        error "new key is bigger than current key"
    A[i] = key
    while i > 1 and A[PARENT(i) > A[i]]
        exchange A[i] with A[PARENT(i)]
        i = PARENT(i)


    MIN-HEAP-INSERT(A, key)
    A.heap_size = A.heap_size + 1
    A[A.heap_size] = +Inf
    HEAP-DECREASE-KEY(A, A.heap_size, key)
