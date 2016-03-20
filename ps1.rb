# This file contains all of the 100,000 integers between 1 and 100,000 (inclusive)
# in some order, with no integer repeated.
#
# Your task is to compute the number of inversions in the file given, where the
# ith row of the file indicates the ith entry of an array.
# Because of the large size of this array, you should implement the fast divide-
# and-conquer algorithm covered in the video lectures. The numeric answer for the
# given input file should be typed in the space below.
# So if your answer is 1198233847, then just type 1198233847 in the space provided
# without any space / commas / any other punctuation marks.

lines = File.readlines("/Users/yi-ke-peng/Documents/MOOCS/AlgorithmsI/IntegerArray.txt")

nums = lines.map { |line| line.to_i }

def merge_and_count(left, right)
  merged = []
  i, j = 0, 0
  split_cnt = 0
  while i < left.length && j < right.length
    if left[i] < right[j]
      merged << left[i]
      i += 1
    else
      merged << right[j]
      j += 1
      split_cnt += left.length - i
    end
  end
  while i < left.length
    merged << left[i]
    i += 1
  end
  while j < right.length
    merged << right[j]
    j += 1
  end
  return merged, split_cnt
end


def sort_and_count(nums, total_cnt)
  if nums.length < 2
    return nums, 0
  else
    middle = nums.length/2
    left, left_cnt = sort_and_count(nums[0...middle], total_cnt)
    right, right_cnt = sort_and_count(nums[middle..-1], total_cnt)
    merged, split_cnt = merge_and_count(left, right)
    total_cnt = left_cnt + right_cnt + split_cnt
    return merged, total_cnt
  end
end

p sort_and_count(nums, 0)
