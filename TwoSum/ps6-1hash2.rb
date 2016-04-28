require "set"

def twosum(buckets)
  sums = Set.new([])
  buckets.each do |k, v|
    buckets[k].each do |x|
      if !buckets[-1 - k].nil?
        buckets[-1 - k].each do |y|
          sums << x + y if x != y
        end
      end
      if !buckets[1 - k].nil?
        buckets[1 - k].each do |y|
          sums << x + y if x != y
        end
      end
    end
  end
  p sums.length
end

def include_y?(y, arr)
  if !buckets[arr].nil?
    buckets[y / 10000].include?(y)
  else
    false
  end
end

if $PROGRAM_NAME == __FILE__
  hash_table = Hash.new
  File.open("test1.txt", "r") do |f|
    f.each_line do |line|
      num = line.strip.to_i
      if hash_table[num / 10000] == nil
        hash_table[num / 10000] = [num]
      else
        hash_table[num / 10000] << num
      end
    end
  end
  twosum(hash_table)
end
