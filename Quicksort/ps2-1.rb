$comparisons = 0

lines = File.readlines("/Users/yi-ke-peng/Documents/MOOCS/AlgorithmsI/QuickSort.txt")
arr = lines.map { |line| line.to_i }
l = 0
r = arr.length - 1

def quicksort(arr, l, r)
  if l >= r
    return arr
  else
    pivot_idx = partition(arr, l, r)
    quicksort(arr, l, pivot_idx - 2)
    quicksort(arr, pivot_idx, r)
  end
end

def partition(arr, l, r)
  pivot_value = arr[l]
  i = l + 1
  (l + 1..r).each do |j|
    if arr[j] < pivot_value
      arr[j], arr[i] = arr[i], arr[j]
      i += 1
    end
  end
  arr[l], arr[i - 1] = arr[i - 1], arr[l]
  $comparisons += r - l
  i
end

p quicksort(arr, l, r)
p $comparisons
