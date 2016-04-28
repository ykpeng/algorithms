require "algorithms"

def median_maintenance(arr)
  low_heap = Containers::MaxHeap.new
  high_heap = Containers::MinHeap.new
  medians = []
  arr.each_with_index do |num, i|
    if low_heap.max.nil? || num < low_heap.max
      low_heap << num
    elsif high_heap.min.nil? || num > high_heap.min
      high_heap << num
    else
      low_heap << num
    end
    if i.even? #length is odd
      if high_heap.length > low_heap.length
        low_heap << high_heap.min!
      end
    else #length is even
      if low_heap.length > high_heap.length
        high_heap << low_heap.max!
      end
    end
    medians << low_heap.max
  end
  # p medians.inject(0, :+)
  p medians.inject(0, :+) % 10000
end

if $PROGRAM_NAME == __FILE__
  arr = []
  File.open("Median.txt", "r") do |f|
    f.each_line do |line|
      arr << line.to_i
    end
  end
  # arr = [11, 3, 6, 9, 2, 8, 4, 10, 1, 12, 7, 5]
  median_maintenance(arr)
end
