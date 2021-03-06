class UnionFind
  def initialize(n)
    @arr = (0...n).to_a
    @rank = Array.new(n, 0)
  end

  def find(i)
    while i != @arr[i]
      @arr[i] = @arr[@arr[i]]
      i = @arr[i]
    end
    i
  end

  def union(v, w)
    i = find(v)
    j = find(w)
    if @rank[i] > @rank[j]
      @arr[j] = i
    elsif @rank[i] < @rank[j]
      @arr[i] = j
    else
      @arr[i] = j
      @rank[j] += 1
    end
  end
end

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
    nodes.each_with_index do |node, a|
      b_hamming = perm ^ node
      b = nodes.index(b_hamming)
      if b
        distance = perm.to_s(2).count("1")
        relevant_edge = [a, b, distance]
        if !res.include?(relevant_edge)
          res << relevant_edge
        end
      end
    end
  end
  res
end

def cluster(sorted_edges, uf, num_of_clusters)
  while sorted_edges != []
    current_edge = sorted_edges.shift
    i = uf.find(current_edge[0])
    j = uf.find(current_edge[1])
    if uf.find(i) != uf.find(j)
      uf.union(i, j)
      # if leaders.count(former) < leaders.count(revised)
      #   leaders.each_index do |i|
      #     if leaders[i] == former
      #       leaders[i] = revised
      #     end
      #   end
      # else
      #   leaders.each_index do |i|
      #     if leaders[i] == revised
      #       leaders[i] = former
      #     end
      #   end
      # end
      num_of_clusters -= 1
    end
  end
  # p leaders
  p num_of_clusters
end

if $PROGRAM_NAME == __FILE__
  lines = File.readlines("clustering_big.txt")
  # num_of_nodes = lines[0].split[0].to_i
  num_of_nodes = 20000
  num_of_bits = lines[0].split[1].to_i
  nodes = []
  # nodes = Set.new
  #store nodes as hamming distances converted into integers
  lines[1..20001].each do |line|
    node = line.gsub(/\s+/, "").to_i(2)
    if !nodes.include?(node)
      nodes << node
    else
      num_of_nodes -= 1
    end
  end
  # num_of_nodes = nodes.length
  one_bit_permutations = bit_permutations(0b1, num_of_bits)
  two_bit_permutations = bit_permutations(0b11, num_of_bits)
  all_permutations = one_bit_permutations + two_bit_permutations
  relevant_edges = find_edges(all_permutations, nodes)
  sorted_edges = relevant_edges.sort_by { |edge| edge[2] }
  # p sorted_edges
  uf = UnionFind.new(num_of_nodes)
  cluster(sorted_edges, uf, num_of_nodes)
end
