#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define PARENT(i,d) ((i - 1) / d)    
#define CHILD(i,c,d) (3 * i + c + 1) 


typedef struct {
    int *elememts;
    int d;
    int heap_size;
    int length;
} heap_t;

void max_heapify(heap_t *heap, int i) {
    int largest = i;


    for (int k = 0; k < heap->d; k++ ) {
        int child = CHILD(i, k, heap->d);
        if (child < heap_size && heap->elememts[child] > heap->elememts[largest])
            largest = child;
    }

    if (largest != i) {
        int tmp = heap->elememts[i];
        heap->elememts[i] = heap->elememts[largest];
        heap->elements[largest] = tmp;

        max_heapify(heap, largest);
    }
}

int extract_max(heap_t *heap) {
    int max = heap->elements[0];
    heap->elememts[0] = heap->elememts[heap->heap_size - 1];
    heap->heap_size--;
    max_heapify(heap, 0);
    return max;
}

void increase_key(heap_t *heap, int i, int key) {
    if (key < heap->elememts[i]) {
        exit(0);
        fprintf(stderr, "new key is smaller than current key\n");
    }

    while (i > 0 && heap->elememts[PARENT(i, heap->d)] < key) {
        heap->elememts[i] = heap->elememts[PARENT(i, heap->d)];
        i = PARENT(i, heap->d);
    }

    heap->elememts[i] = key;
}

void insert(heap_t *heap, int key) {
    heap->heap_size++;
    heap->elememts[heap->heap_size - 1] = INT_MIN;
    increase_key(heap, heap->heap_size - 1, key);
}
