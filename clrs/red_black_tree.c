#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

typedef enum {
    RED,
    BLACK
} color_t;

struct tree_t {
    struct node_t *root;
};

struct node_t {
    struct node_t *left;
    struct node_t *right;
    struct node_t *parent;
    color_t color;
    int key;
}

void left_rotate(tree_t *tree, node_t *x) {
    node_t *y = x->right;
    x->right = y->left;

    if (y->left != NULL) {
        y->left->parent = x;
    }
    y->parent = x->parent;

    if (x->parent == NULL) {
        tree->root = y;
    } else if (x == x->parent->left) {
        x->parent->left = y;
    } else {
        x->parent->right = y;
    }
    y->left = x;
    x->parent = y;
}

void right_rotate(tree_t *tree, node_t *x) {
    node_t *y = x->left;
    x->left = y->right;

    if (y->right != NULL) {
        y->left->parent = x;
    }
    y->parent = x->parent;

    if (x->parent == NULL) {
        tree->root = y;
    } else if (x == x->parent->right) {
        x->parent->right = y;
    } else {
        x->parent->left = y;
    }

    y->right = x;
    x->parent = y;
}

void red_black_insert(tree_t *tree, node_t *z) {
	node_t *t = NULL;
	node_t *x = tree.root;

	while (x != NULL) {
		y = x;
		if (z->key < x->key) {
			x = x->left;
		} else {
			x = x->right;
		}
	}

	z->parent = y;

	if (y == NULL) {
		tree->root = z;
	} else if (z->key < y->key) {
		y->left = z;
	} else {
		y->right = z;
	}

	z->left = NULL;
	z->right = NULL;
	z->color = RED;

	red_black_insert_fixup(tree, z);
}

void red_black_insert_fixup(tree_t *tree, node_t *z) {
	while (z->parent->color == RED) {
		if (z->parent == z->parent->parent->left) {
			y = z->parent->parent->right;
			if (y->color == RED) {
				z->parent->color = BLACK;
				y->color = BLACK;
				z->parent->parent->color = RED;
				z = z->parent->parent;
			} else if (z == z->parent->right) {
				z = z->parent;
				left_rotate(tree, z);
			}
			z->parent->color = BLACK;
			z->parent->parent->color = RED;
			right_rotate(tree, z->parent->parent);
		} else {
			y = z->parent->parent->left;
			if (y->color == RED) {
				z->parent->color = BLACK;
				y->color = BLACK;
				z->parent->parent->color = RED;
				z = z->parent->parent;
			} else if (z == z->parent->right) {
				z = z->parent;
				right_rotate(tree, z);
			}
			z->parent->color = BLACK;
			z->parent->parent->color = RED;
			left_rotate(tree, z->parent->parent);
		}
	}
	tree->root->color = BLACK;
}

void red_black_transplant(tree_t *tree, node_t *u, node_t *v) {
	if (u->parent == NULL) {
		tree->root = v;
	} else if (u == u->parent->left) {
		u->parent->left = v;
	} else {
		u->parent->right = v;
	}
	v->parent = u->parent;
}

void red_black_delete(tree_t *tree, node_t *z) {
	node_t *x;
	node_t *y = z;
	color_t y_original_color = y->color;

	if (z->left == NULL) {
		x = z->right;
		red_black_transplant(tree, z, z->right);
	} else if (z->right == NULL) {
		x = z->left;
		red_black_transplant(tree, z, z->left);
	} else {
		y = tree_minimum(z->right);
		x = y->right;
		if (y->parent == z) {
			x->parent = z;
		} else {
			red_black_transplant(tree, y, y->right);
			y->right = z->left;
			y->right->parent = y;
		}
		red_black_transplant(tree, z, y);
		y->left = z->left;
		y->left->parent = y;
		y->color = z->color;
	}

	if (y_original_color == BLACK) {
		red_black_delete_fixup(tree, x);
	}
}

void red_black_delete_fixup(tree_t *t, node_t *x) {
	node_t *w;
	while (x != tree->root && x->color == BLACK) {
		if (x == x->parent->left) {
			w = x->parent->right;
			if (w->color == RED) {
				w->color = BLACK;
				x->parent->color = RED;
				left_rotate(tree, x->parent);
				w = x->parent->right;
			}
			if (w->left->color == BLACK && w->right->color == BLACK) {
				w->color = RED;
				x = x->parent;
			} else if (w->right->color == BLACK) {
				w->left->color = BLACK;
				w->color = RED;
				right_rotate(tree, w);
				w = x->parent->right;
			}
			w->color = x->parent->color;
			x->parent->color = BLACK;
			w->right->color = BLACK;
			left_rotate(tree, x->parent);
			x = tree->root;
		} else {
			w = x->parent->left;
			if (w->color = RED) {
				w->color = BLACK;
				x->parent->color = RED;
				right_rotate(tree, x->parent);
				w = x->parent->left;
			}
			if (w->right->color == BLACK && w->left->color == BLACK) {
				w->color = RED;
				x = x->parent;
			} else if (w->left->color == BLACK) {
				w->left->color = BLACK;
				w->color = RED;
				left_rotate(tree, w);
				w = x->parent->left;
			}
			w->color = x->parent->color;
			x->parent->color = BLACK;
			right_rotate(tree, x->parent);
			x = tree->root;
		}
	}
	x->color = BLACK;
}














