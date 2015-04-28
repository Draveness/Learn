void max_heapify(A, i) {
    int l = left(i);
    int r = right(i);
    int largest;
    if (l <= A.heap_size && A[l] > A[i]) {
        largest = l;
    } else {
        largest = i;
    }

    if (r <= A.heap_size && A[r] > A[largest]) {
        largest = r;
    }

    if (largest != i) {
        int temp = A[i];
        A[i] = A[largest];
        A[largest] = temp;
        max_heapify(A, largest);
    }
}

void build_max_heap(A) {
    A.heap_size = A.length;
    for (i = A.length / 2; i > 0; i--) {
        max_heapify(A, i);
    }
}
