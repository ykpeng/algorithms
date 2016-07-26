def knapsack(items, knapsack_capacity, num_of_items)
  arr = []
  2.times do |i|
    arr[i] = []
    (0..knapsack_capacity).each do |x|
      arr[i] << 0
    end
  end

  (1..num_of_items).each do |i|
    (0..knapsack_capacity).each do |x|
      case_one = arr[(i - 1) % 2][x]
      if items[i - 1][1] > x
        arr[i % 2][x] = case_one
      else
        case_two = arr[(i - 1) % 2][x - items[i - 1][1]] + items[i - 1][0]
        arr[i % 2][x] = [case_one, case_two].max
      end
    end
  end
  # p arr
  p arr[num_of_items % 2][knapsack_capacity]
end

if $PROGRAM_NAME == __FILE__
  lines = File.readlines("knapsack_big.txt")
  # knapsack_capacity = 3000
  knapsack_capacity = lines[0].split[0].to_i
  num_of_items = lines[0].split[1].to_i
  items = []
  lines[1..-1].each do |line|
    items << line.split.map { |char| char.to_i }
  end
  sorted_items = items.sort_by { |arr| arr[1] }
  knapsack(sorted_items, knapsack_capacity, num_of_items)
end
