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

#nums = [4, 80, 70, 23, 9, 60, 68, 27, 66, 78, 12, 40, 52, 53, 44, 8, 49, 28, 18, 46, 21, 39, 51, 7, 87, 99, 69, 62, 84, 6, 79, 67, 14, 98, 83, 0, 96, 5, 82, 10, 26, 48, 3, 2, 15, 92, 11, 55, 63, 97, 43, 45, 81, 42, 95, 20, 25, 74, 24, 72, 91, 35, 86, 19, 75, 58, 71, 47, 76, 59, 64, 93, 17, 50, 56, 94, 90, 89, 32, 37, 34, 65, 1, 73, 41, 36, 57, 77, 30, 22, 13, 29, 38, 16, 88, 61, 31, 85, 33, 54]

nums = []
filename = "/Users/yi-ke-peng/Documents/MOOCS/AlgorithmsI/IntegerArray.txt"
with open(filename, 'r') as infile:
    for line in infile:
        nums.append(int(line.strip()))

def merge_and_count(left, right):
  merged = []
  i, j = 0, 0
  split_cnt = 0
  while i < len(left) and j < len(right):
    if left[i] < right[j]:
      merged.append(left[i])
      i += 1
    else:
      merged.append(right[j])
      j += 1
      split_cnt += len(left) - i
  while i < len(left):
    merged.append(left[i])
    i += 1
  while j < len(right):
    merged.append(right[j])
    j += 1
  return (merged, split_cnt)


def sort_and_count((nums, total_cnt)):
  if len(nums) < 2:
    return (nums, 0)
  else:
    middle = len(nums)/2
    (left, left_cnt) = sort_and_count((nums[:middle], total_cnt))
    (right, right_cnt) = sort_and_count((nums[middle:], total_cnt))
    (merged, split_cnt) = merge_and_count(left, right)
    total_cnt = left_cnt + right_cnt + split_cnt
    return (merged, total_cnt)
    
print sort_and_count((nums, 0))