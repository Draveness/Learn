class LinkList
	attr_accessor :head
	
	def initialize
		@head = nil
	end

	def search(key)
		x = @head
		while x != nil && x.value != key
			x = x.next
		end
		x
	end

	def insert(node)
		node.next = @head
		@head.prev = node if @head != nil
		@head = node
		node.prev = nil
	end

	def delete(node)
		if node.prev != nil
			node.prev.next = node.next
		else
			@head = node.next
		end
		node.next.prev = node.prev if node.next != nil
	end

end

class Node
	attr_accessor :prev, :value, :next

	def initialize(value)
		@prev = nil
		@value = value
		@next = nil
	end

end

node_1 = Node.new(1)
node_2 = Node.new(2)
node_3 = Node.new(3)
node_4 = Node.new(4)

link_list = LinkList.new
link_list.insert(node_1)
link_list.insert(node_2)
link_list.insert(node_3)
link_list.insert(node_4)
