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

def cluster(sorted_edges, uf, num_of_clusters, k)
  while num_of_clusters > k
    current_edge = sorted_edges.shift
    i = current_edge[0]
    j = current_edge[1]
    if uf.find(i) != uf.find(j)
      uf.union(i, j)
      num_of_clusters -= 1
    end
  end
  while true
    current_edge = sorted_edges.shift
    i = current_edge[0]
    j = current_edge[1]
    if uf.find(i) != uf.find(j)
      return current_edge[2]
    end
  end
end

if $PROGRAM_NAME == __FILE__
  lines = File.readlines("clustering1.txt")
  num_of_clusters = lines[0].to_i
  edges = []
  lines[1..-1].each do |line|
    split_line = line.split.map { |str| str.to_i }
    edges << split_line
  end
  sorted_edges = edges.sort_by { |edge| edge[2] }
  uf = UnionFind.new(num_of_clusters + 1)
  k = 4
  p cluster(sorted_edges, uf, num_of_clusters, k)
end
