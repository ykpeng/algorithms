require "set"
require "bisect"

def twosum(arr)
  sums = Set.new([])
  arr.each do |x|
    lower = Bisect.bisect_left(arr, (-10000 - x))
    upper = Bisect.bisect_right(arr, (10000 - x))
    arr[lower...upper].each do |y|
      sums << x + y if y != x
    end
  end
  p sums.length
end

if $PROGRAM_NAME == __FILE__
  arr = []
  File.open("2sum.txt", "r") do |f|
    f.each_line do |line|
      arr << line.to_i
    end
  end
  sorted_arr = arr.sort
  twosum(sorted_arr)
end
