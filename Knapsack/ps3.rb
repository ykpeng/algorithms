def knapsack(values, weights, knapsack_capacity, num_of_items)
  arr = []
  (0..num_of_items).each do |i|
    arr[i] = []
    (0..knapsack_capacity).each do |x|
      arr[i] << 0
    end
  end
  (1..num_of_items).each do |i|
    (1..knapsack_capacity).each do |x|
      case_one = arr[i - 1][x]
      if weights[i - 1] > x
        arr[i][x] = case_one
      else
        case_two = arr[i - 1][x - weights[i - 1]] + values[i - 1]
        arr[i][x] = [case_one, case_two].max
      end
    end
  end
  # p display(arr)
  p arr[num_of_items][knapsack_capacity]
end

def display(arr)
  arr.each do |row|
    p row
  end
  puts
end

if $PROGRAM_NAME == __FILE__
  lines = File.readlines("knapsack1.txt")
  # knapsack_capacity = 3000
  knapsack_capacity = lines[0].split[0].to_i
  num_of_items = lines[0].split[1].to_i
  values = []
  weights = []
  lines[1..-1].each do |line|
    values << line.split[0].to_i
    weights << line.split[1].to_i
  end
  knapsack(values, weights, knapsack_capacity, num_of_items)
end
