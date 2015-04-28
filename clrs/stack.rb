class Stack
	def initialize
		@elements = []
	end

	def push(x)
		@elements[@elements.size] = x
	end

	def pop
		raise "Cannot pop empty stack!" if @elements.size < 0
		result = @elements[@elements.size - 1]
		@elements[@elements.size - 1] = nil
		result
	end

end
