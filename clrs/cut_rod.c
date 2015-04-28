/*
 * =====================================================================================
 *
 *       Filename:  cut_rod.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  04/08/2015 11:17:30
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

#define MAX(a,b) (a > b ? a : b)

int cut_rod(int *p, int n) {
    if (n == 0) {
        return 0;
    }
    int q = INT_MIN;
    for (int i = 0; i < n; i++) {
        q = MAX(q, p[i] + cut_rod(p, n - i - 1));
    }
    printf("q = %d, n = %d\n", q, n);
    return q;
}

int main(int argc, char *argv[]) {
    int p[10] = {1,5,8,9,10,17,17,20,24,30};
    printf("%d\n",cut_rod(p,20));
}
