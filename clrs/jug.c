/*
 * =====================================================================================
 *
 *       Filename:  jug.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  03/25/2015 13:02:45
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Draven (), stark.draven@gmail.com
 *   Organization:  
 *
 * =====================================================================================
 */

#include <stdlib.h>

typedef int jug;

static int tmp;
#define EXCHANGE(a, b) {tmp = a; a = b; b = tmp;}

int cmp(jug red, jug blue) {
    return red - blue;
}

void quadratic_pair(jug *red, jug *blue, int size) {
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            if (cmp(red[i], blue[j]) == 0) {
                EXCHANGE(blue[i], blue[j]);
            }
        }
    }
}

void quicksort_pair(jug *red, jug *blue, int p, int r) {
    if (p < r - 1) {
        int q = partition_pair(red, blue, p, r);
        quadratic_pair(red, blue, p, q - 1);
        quadratic_pair(red, blue, q + 1, r);
    }
}

int partition_pair(jug *red, jug *blue, int p, int q) {
    int pivot, i;
    jug red_pivot, blue_pivot;

    i = rand() % (q - p) + p;
    EXCHANGE(red[i], red[q - 1]);
    red_pivot = red[q - 1];

    for (int i = p; i < q; i++) {
        if (cmp(red_pivot, blue[i]) == 0) {
            EXCHANGE(blue[i], blue[q - 1]);
            break;
        }
    }

    pivot = p;
    for (int i = p; i < r; i++) {
        if (cmp(red_pivot, blue[i]) > 0) {
            EXCHANGE(blue[pivot], blue[i]);
            pivot++;
        }
    }
    EXCHANGE(blue[q-1], blue[pivot]);
    blue_pivot = blue[pivot];

    int j = p;
    for (int i = p; i < r; i++) {
        if (cmp(red[i], blue_pivot) < 0) {
            EXCHANGE(red[j], red[i]);
            j++;
        }
    }
    EXCHANGE(red[q-1], red[j]);

    return pivot;
}

int cmp(jud red, jud blue) {
    return red - blue;
}
