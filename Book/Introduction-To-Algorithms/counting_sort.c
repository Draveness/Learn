/*
 * =====================================================================================
 *
 *       Filename:  counting_sort.c
 *
 *    Description:  Naive counting sort algorithm
 *
 *        Version:  1.0
 *        Created:  03/25/2015 19:02:11
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Draven (), stark.draven@gmail.com
 *   Organization:  
 *
 * =====================================================================================
 */

void counting_sort(int A[], int B[], int k) {
    int C[k+1];
    
    for (int i = 0; i <= k; i++) {
        C[i] = 0;
    }

    for (int j = 0; j < length(A); j++) { C[A[j]]++; }
    for (int i = 1; i <= k; i++) { C[i] += C[i-1]; }
    
    for (int j = length(A) - 1; j >= 0; j--) {
        B[C[A[j]]] = A[j];
        C[A[j]]--;
    }
}
