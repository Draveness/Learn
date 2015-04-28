/*
 * =====================================================================================
 *
 *       Filename:  hoare_partition_quicksort.c
 *
 *    Description:  Quicksort use hoare partition
 *
 *        Version:  1.0
 *        Created:  03/22/2015 15:58:14
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Draven (), stark.draven@gmail.com
 *   Organization:  
 *
 * =====================================================================================
 */
#include <stdbool.h>

int hoare_partition(int A[], int p, int r) {
    int x = A[p],
        i = p - 1,
        j = r + 1;
    while (true) {
        do { j--; } while (!(A[j] <= x));
        do { i++; } while (!(A[i] >= x));
        if (i < j) {
            A[i] ^= A[j] ^= A[i] ^= A[j];
        } else {
            return j;
        }
    }
}

void quicksort(int A[], int p, int r) {
    if (p < r - 1) {
        int q = hoare_partition(A, p, r);
        quicksort(A, p, q - 1);
        quicksort(A, q + 1, r);
    }
}
