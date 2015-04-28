/*
 * =====================================================================================
 *
 *       Filename:  variable_length_items_sorting.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  03/25/2015 12:04:02
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Draven (), stark.draven@gmail.com
 *   Organization:  
 *
 * =====================================================================================
 */

#include <math.h>
#include <string.h>

#define MAX_LENGTH

union key_t {
    int number;
    char string[MAX_LENGTH + 1];
}

typedef struct {
    union key_t key;
    int value;
} item;

typedef int (*key_f)(item, int);
typedef int (*dimension_f)(item);
typedef int (*compare_f)(item, item);

void partition(item *A, int size, int digits, int *groups, dimension_f dimension);
void radix_sort(item *A, int left, int right, int digits, key_f key);
void counting_sort(item *A, int left, int right, int dimension, key_f key, int key_index);

int item_nth_digit(item i, int d);
int item_digits(item i);

int item_string_length(item i);
int item_nth_char(item i, int d);

void sort_numbers(item *A, int size, int max_digits) {
    int groups[max_digits + 1];

    partition(A, size, max_digits, groups, i, item_digits);

    for (int i = 1; i < max_digits + 1; i++) {
        radix_sort(A, group[i - 1], groups[i], i, item_nth_digit);
    }
}
