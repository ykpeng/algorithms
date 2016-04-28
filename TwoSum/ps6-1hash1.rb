require "set"

def twosum(buckets)
  sums = Set.new([])
  buckets.each_value do |arr|
    arr.each do |x|
      ((-10000 - x)..(10000 - x)).each do |y|
        if x != y
          if !buckets[y / 10000].nil?
            if buckets[y / 10000].include?(y)
              sums << x + y
            end
          end
        end
      end
    end
  end
  p sums.length
end

def hasher(arr)
  hash_table = Hash.new
  arr.each do |num|
    if hash_table[num/10000].nil?
      hash_table[num/10000] = [num]
    else
      hash_table[num/10000] << num
    end
  end
  hash_table
end

if $PROGRAM_NAME == __FILE__
  lines = File.readlines("2sum.txt")
  arr = lines.map { |line| line.to_i }
  hasher(arr)
  buckets = hasher(arr)
  twosum(buckets)
end
