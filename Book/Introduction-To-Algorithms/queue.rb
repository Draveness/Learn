class Queue

	def initialize
		@elements = []
	end

	def enqueue(x)
		@elements[@elements.size] = x
	end

	def dequeue
		raise "Queue is empty!" if @elements.size == 0
		result = @elements.shift
		result
	end

end
