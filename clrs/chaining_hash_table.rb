class ChainedHashTable
	
	def initialize
		@table = []
	end

	def insert(x)
		if @table[x.key.hash]
			@table[x.key.hash] << x
		else
			@table[x.key.hash] = [x]
		end	
	end

	def search(k)
		@table[k.hash].each do |key|
			if key == k
				return k
			end
		end
	end

	def delete(x)
		@table[x.key.hash].delete(x)
	end

end
