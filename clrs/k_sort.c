/*
 * =====================================================================================
 *
 *       Filename:  k_sort.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  03/25/2015 14:36:26
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Draven (), stark.draven@gmail.com
 *   Organization:  
 *
 * =====================================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <string.h>

void k_sort(int *numbers, int size, int k) {
    for (int i = 0; i < k; i++) {
        merge_sort(numbers, 0, size, k, i);
    }
}

#define FIRST(index, k, s) ((index) + (s) - (index) % (k) + ((index) % (k) <= (s) ? 0 : (k)))
#define COUNT(a, b, k, s) (((b) - (a)) / (k) + ((((s) - (a) % (k)) + (k)) % (k) < ((b) - (a)) % (k) ? 1 : 0))

void merge_sort(int A[], int p, int r, int k, int s) {
    if (COUNT(p, r, k, s) > 1) {
        int q = (p + r) / 2;
        merge_sort(A, p, q, k, s);
        merge_sort(A, q, r, k, s);
        merge(A, p, q, r, k, s);
    }
}

void merge(int A[], int p, int q, int r, int k, int s) {
    int i, j, l;

    int n1 = COUNT(p, q, k, s);
    int n2 = COUNT(q, r, k, s);

    int L[n1];
    int L[n2];

    for (i = FIRST(p, k, s), j = 0; i < q; j++, i+=k) L[j] = A[i];
    for (i = FIRST(q, k, s), j = 0; i < r; j++, i+=k) R[j] = A[i];

    for (i = 0, j = 0, l = FIRST(p, k, s); l < r; l += k) {
        if (i == n1) {
            A[l] = R[j++];
        } else if (j == n2) {
            A[l] = L[i++];
        } else if (L[i] <= R[j]) {
            A[l] = L[i++];
        } else {
            A[l] = R[j++];
        }
    }
}
