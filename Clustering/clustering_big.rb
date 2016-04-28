def bit_permutations(x, num_of_bits)
  permutations = []
  while x.to_s(2).length <= num_of_bits
    permutations << x
    y = x & -x
    c = x + y
    x = (((x ^ c) >> 2) / y) | c
  end
  permutations
end

def find_edges(all_permutations, nodes)
  res = []
  all_permutations.each do |perm|
    nodes.each do |node|
      b = perm ^ node
      distance = perm.to_s(2).count("1")
      relevant_edge = [node, b, distance]
      if nodes.include?(b) && !res.include?(relevant_edge)
        res << relevant_edge
      end
    end
  end
  res
end

# def find_edges(all_permutations, nodes)
#   res = []
#   all_permutations.each do |perm|
#     nodes.each_with_index do |node, a|
#       b_hamming = perm ^ node
#       if nodes.include?(b_hamming)
#         b = nodes.index(b_hamming)
#         distance = perm.to_s(2).count("1")
#         relevant_edge = [a, b, distance]
#         if !res.include?(relevant_edge)
#           res << relevant_edge
#         end
#       end
#     end
#   end
#   res
# end

# def find_index(nodes, b_hamming)
#   nodes.each_with_index do |n, i|
#     if n == b_hamming
#       return i
#     end
#   end
#   nil
# end

def cluster(sorted_edges, leaders, num_of_clusters)
  while sorted_edges != []
    current_edge = sorted_edges.shift
    if leaders[current_edge[0]] != leaders[current_edge[1]]
      former = leaders[current_edge[1]]
      revised = leaders[current_edge[0]]
      leaders.each_key do |i|
        if leaders[i] == former
          leaders[i] = revised
          # p leaders
        end
      end
      num_of_clusters -= 1
    end
  end
  # p leaders
  p num_of_clusters
end

if $PROGRAM_NAME == __FILE__
  lines = File.readlines("test4.txt")
  # num_of_nodes = 666
  num_of_nodes = lines[0].split[0].to_i
  num_of_bits = lines[0].split[1].to_i
  nodes = []
  #nodes stored as hamming distances
  lines[1..-1].each do |line|
    node = line.gsub(/\s+/, "").to_i(2)
    if !nodes.include?(node)
      nodes << node
    else
      num_of_nodes -= 1
    end
  end
  # p nodes
  one_bit_permutations = bit_permutations(0b1, num_of_bits)
  two_bit_permutations = bit_permutations(0b11, num_of_bits)
  all_permutations = one_bit_permutations + two_bit_permutations
  relevant_edges = find_edges(all_permutations, nodes)
  sorted_edges = relevant_edges.sort_by { |edge| edge[2] }
  # p sorted_edges
  # leaders = (0...num_of_nodes).to_a
  leaders = {}
  sorted_edges.each do |edge|
    leaders[edge[0]] = edge[0]
    leaders[edge[1]] = edge[1]
  end
  cluster(sorted_edges, leaders, num_of_nodes)
end
