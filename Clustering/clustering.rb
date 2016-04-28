def cluster(sorted_edges, leaders, num_of_clusters, k)
  while num_of_clusters > k
    current_edge = sorted_edges.shift
    if leaders[current_edge[0]] != leaders[current_edge[1]]
      former = leaders[current_edge[1]]
      revised = leaders[current_edge[0]]
      leaders.each_index do |i|
        if leaders[i] == former
          leaders[i] = revised
        end
      end
      num_of_clusters -= 1
    end
  end
  while true
    current_edge = sorted_edges.shift
    if leaders[current_edge[0]] != leaders[current_edge[1]]
      return current_edge[2]
    end
  end
end

if $PROGRAM_NAME == __FILE__
  lines = File.readlines("test1.txt")
  num_of_clusters = lines[0].to_i
  edges = []
  lines[1..-1].each do |line|
    split_line = line.split.map { |str| str.to_i }
    edges << split_line
  end
  sorted_edges = edges.sort_by { |edge| edge[2] }
  leaders = (0..num_of_clusters).to_a
  k = 4
  p cluster(sorted_edges, leaders, num_of_clusters, k)
end
