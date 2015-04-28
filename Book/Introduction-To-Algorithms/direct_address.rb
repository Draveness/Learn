class DirectAddressTable

	def initialize
		@table = []
	end

	def search(k)
		@table[k]
	end

	def insert(x)
		@table[x] = x
	end

	def delete(x)
		@table[x] = nil
	end

end
