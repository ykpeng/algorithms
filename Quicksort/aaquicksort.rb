def quicksort(arr)
  if arr.length < 2
    arr
  else
    pivot = [arr[0]]
    left_arr = arr[1..-1].select { |num| num < arr[0] }
    right_arr = arr[1..-1].select { |num| num > arr[0] }
    quicksort(left_arr) + pivot + quicksort(right_arr)
  end
end
