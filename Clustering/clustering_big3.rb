def find(i, nodes)
  while i != nodes[i][0]
    nodes[i][0] = nodes[nodes[i][0]][0]
    i = nodes[i][0]
  end
  i
end

def union(v, w, nodes)
  i = find(v, nodes)
  j = find(w, nodes)
  if nodes[i][1] > nodes[j][1]
    nodes[j][0] = i
  elsif
    nodes[i][0] = j
    if nodes[i][1] == nodes[j][1]
      nodes[j][1] += 1
    end
  end
end

def bit_permutations(x, num_of_bits)
  permutations = []
  x_str = x.to_s(2)
  while x_str.length <= num_of_bits
    permutations << x_str
    y = x & -x
    c = x + y
    x = (((x ^ c) >> 2) / y) | c
  end
  permutations
end

# def find_edges(permutations, nodes, distance)
#   res = []
#   permutations.each do |perm|
#     nodes.each_with_index do |node, a|
#       b_hamming = perm ^ node
#       b = nodes.index(b_hamming)
#       if b
#         relevant_edge = [a, b, distance]
#         if !res.include?(relevant_edge)
#           res << relevant_edge
#         end
#       end
#     end
#   end
#   res
# end

def cluster(relevant_nodes, nodes, num_of_clusters)
  nodes.each_key do |a|
    relevant_nodes.each do |b|
      if find(a, nodes) != find(b, nodes)
        union(a, b, nodes)
        num_of_clusters -= 1
      end
    end
  end
  # p leaders
  p num_of_clusters
end

if $PROGRAM_NAME == __FILE__
  lines = File.readlines("clustering_big.txt")
  # num_of_nodes = lines[0].split[0].to_i
  num_of_nodes = 666
  num_of_bits = lines[0].split[1].to_i
  nodes = {}
  # nodes = Set.new
  #store nodes as hamming distances converted into integers
  lines[1..667].each do |line|
    node = line.gsub(/\s+/, "")
    if !nodes.include?(node)
      nodes[node] = [node, 0]
    else
      num_of_nodes -= 1
    end
  end
  # num_of_nodes = nodes.length
  all_permutations = bit_permutations(0b1, num_of_bits) + bit_permutations(0b11, num_of_bits)
  relevant_nodes = (all_permutations & nodes.keys).uniq
  # p sorted_edges
  cluster(relevant_nodes, nodes, num_of_nodes)
end
