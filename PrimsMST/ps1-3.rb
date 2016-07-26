def primsMST(graph, start)
  vertices_spanned = [start]
  tree_so_far = []
  while vertices_spanned.length != graph.keys.length
    e = min_edge(vertices_spanned, graph)
    tree_so_far << e
    vertices_spanned << e[0][1]
  end
  tree_so_far
end

def min_edge(vertices_spanned, graph)
  min_edge = nil
  min_cost = 1.0/0
  vertices_spanned.each do |u|
    if !graph[u].nil?
      graph[u].each do |v|
        if !vertices_spanned.include?(v[0]) && v[1] < min_cost
          min_edge = [u, v[0]]
          min_cost = v[1]
        end
      end
    end
  end
  [min_edge, min_cost]
end

def total_cost(tree)
  sum = 0
  tree.each do |edge|
    sum += edge[1]
  end
  p sum
end

if $PROGRAM_NAME == __FILE__
  lines = File.readlines("test1.txt")
  number_of_nodes = lines[0].split[0].to_i
  number_of_edges = lines[0].split[1].to_i
  graph = {}
  lines[1..-1].each do |line|
    split_line = line.split.map { |str| str.to_i }
    if graph[split_line[0]].nil?
      graph[split_line[0]] = [split_line[1..-1]]
    else
      graph[split_line[0]] << split_line[1..-1]
    end
    if graph[split_line[1]].nil?
      graph[split_line[1]] = [[split_line[0], split_line[2]]]
    else
      graph[split_line[1]] << [split_line[0], split_line[2]]
    end
  end
  start = rand(number_of_nodes + 1)
  min_spanning_tree = primsMST(graph, start)
  p min_spanning_tree
  # total_cost(min_spanning_tree)
end
