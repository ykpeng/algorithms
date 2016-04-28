require "set"

def twosum(arr)
  sums = Set.new([])
  arr.each do |x|
    lower = find_idx_left(arr, (-10000 - x))
    upper = find_idx_right(arr, (10000 - x))
    arr[lower...upper].each do |y|
      sums << x + y if y != x
    end
  end
  p sums.length
end

def find_idx_left(arr, num)
  high_idx = arr.length - 1
  low_idx = 0
  while low_idx <= high_idx
    mid_idx = (high_idx + low_idx) / 2
    mid = arr[mid_idx]
    if num == mid
      return mid_idx
    elsif num < mid
      high_idx = mid_idx - 1
    else
      low_idx = mid_idx + 1
    end
  end
  if num > mid
    return mid_idx + 1
  else
    return mid_idx
  end
end

def find_idx_right(arr, num)
  high_idx = arr.length - 1
  low_idx = 0
  while low_idx <= high_idx
    mid_idx = (high_idx + low_idx) / 2
    mid = arr[mid_idx]
    if num == mid
      return mid_idx + 1
    elsif num < mid
      high_idx = mid_idx - 1
    else
      low_idx = mid_idx + 1
    end
  end
  if num > mid
    return mid_idx + 1
  else
    return mid_idx
  end
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
