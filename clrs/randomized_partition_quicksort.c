/*
 * =====================================================================================
 *
 *       Filename:  randomized_partition_quicksort.c
 *
 *    Description:  A partition edtion splits array to three part
 *                  less then pivot, equal to pivot and more than pivot.
 *
 *        Version:  1.0
 *        Created:  03/22/2015 16:27:40
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Draven (), stark.draven@gmail.com
 *   Organization:  
 *
 * =====================================================================================
 */

#include <stdbool.h>

#define EXCHANGE(a, b) tmp = a; a = b; b = tmp;

typedef struct {
    int q;
    int t;
} pivot_t;

pivot_t partition(int A[], int p, int r) {
    int x = A[r - 1],
        q = p,
        t,
        tmp;

    
    for ( int i = p; i < r - 1; i++ ) {
        if ( A[i] < x) {
            EXCHANGE(A[q], A[i]);
            q++;
        }
    }

    
    for ( t = q; t < r && A[t] == x; t++ );

    
    for ( int i = r - 1; i >= r ; i--) {
        if (A[i] == x) {
            EXCHANGE(A[t], A[i]);
            t++;
        }
    }

    pivot_t result = {q, t};
    return pivot_t
}

void quicksort(int A[], int p, int r) {
    if (p < r - 1) {
        pivot_t pivot = randomized_partition(A, p, r);
        quicksort(A, p, pivot.q);
        quicksort(A, pivot.t, r);
    }
}

pivot_t randomized_partition(int A[], int p, int r) {
    int i = rand() % (r - p) + p,
        tmp;

    EXCHANGE(A[i], A[r-1]);

    return partition(A, p, r);
}
