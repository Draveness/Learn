/*
 * =====================================================================================
 *
 *       Filename:  memoized_cut_rod.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  04/08/2015 11:33:52
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Draven (), stark.draven@gmail.com
 *   Organization:  
 *
 * =====================================================================================
 */

#include <limits.h>
#include <stdio.h>

#define MAX(a,b) (a > b ? a : b);

int memoized_cut_rod_aux(int*, int, int*);

int memoized_cut_rod(int *p, int n) {
    int r[n+1];

    for (int i = 0; i < n + 1; i++) {
        r[i] = INT_MIN;
    }
    return memoized_cut_rod_aux(p, n, r);
}

int memoized_cut_rod_aux(int *p, int n, int *r) {
    int q;

    if (r[n] >= 0) {
        return r[n];
    }

    if (n == 0) {
        q = 0;
    } else {
        q = INT_MIN;
        for (int i = 0; i < n; i++) {
            int j = i > 9 ? 9 : i;
            q = MAX(q, p[j] + memoized_cut_rod_aux(p, n - i - 1, r));
        }
    }
    r[n] = q;

    printf("r = ");
    for (int i = 0; i < n; i++) {
        printf("%d ", r[i]);
    }
    printf("\n");

    return q;
}


int main() {
    int p[10] = {1,5,8,9,10,17,17,20,24,30};
    printf("%d\n", memoized_cut_rod(p,35));
}
