class OpenAddressHashTable

	def initialize(max)
		@max = max
		@table = []
	end

	def insert(k)
		i = 0
		
		until i == m
			j = k.hash(i)
			if @table[j] == nil
				@table[j] = k
				return j
			else
				i = i + 1
			end
		end
		
		raise "Hash table overflow!"
	end

	def search(k)
		i = 0

		until @table[j] == nil || i == m
			j = k.hash(i)
			if @table[j] == nil
				return j
			end
			i = i + 1
		end

		nil
	end

end
