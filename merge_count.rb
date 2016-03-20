class MergeSortAndCount

  attr_accessor :inversions

  def initialize
    @inversions = 0
  end

  def merge_sort(array)
    #split it into left and right
    #sort the left and sort the right

    #base case
    return array if array.size <= 1

    mid = array.size / 2
    left = merge_sort(array.take(mid))
    right = merge_sort(array.drop(mid))

    merged = merge(left, right)

    return merged
  end


  def merge(left, right)
    result = []

    until left.empty? || right.empty?
      if left.first < right.first
        result.push(left.shift)
      else
        @inversions += left.size
        result.push(right.shift)
      end
    end

    return result.concat(left).concat(right)
  end
end



#Driver
program = MergeSortAndCount.new
p program.merge_sort(array)
p program.inversions
