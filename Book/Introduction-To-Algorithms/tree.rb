def tree_minimum(tree)
	return tree if tree.left == nil
	tree_minimum(tree.left)
end
