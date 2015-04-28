/*
 * =====================================================================================
 *
 *       Filename:  randomized_select.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  03/27/2015 19:46:27
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Draven (), stark.draven@gmail.com
 *   Organization:  
 *
 * =====================================================================================
 */

#define EXCHANGE(a, b) tmp = a; a = b; b = tmp;

int randomized_select(int A[], int p, int r, int i) {
    int q, k;
    if (p == r) {
        return A[p];
    }

    q = randomized_partition(A, p, r);
    k = q - p + 1;

    if (i == k) {
        return A[q];
    } else if (i < k) {
        return randomized_select(A, p, q - 1, i);
    } else {
        return randomized_select(A, q + 1, r, i - k);
    }
}

int randomized_partition(int A[], int p, int r) {
    int i = rand() % (r - p) + p,
        tmp;

    EXCHANGE(A[i], A[r - 1]);

    return partition(A, p, r);
}

int partition(int A[], int p, int r) {
    int x = A[r - 1],
        i = p - 1;

    for (int j = p; j < r; j++) {
        if (A[j] <= x) {
            i++;
            EXCHANGE(A[j], A[i]);
        }
    }
    EXCHANGE(A[r], A[i + 1]);
    return i + 1;
}
