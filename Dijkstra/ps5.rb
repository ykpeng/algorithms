# In this programming problem you'll code up Dijkstra's shortest-path
# algorithm.
#
# The file contains an adjacency list representation of an
# undirected  weighted graph with 200 vertices labeled 1 to 200. Each
# row consists  of the node tuples that are adjacent to that particular
# vertex along with the length of that edge. For example, the 6th row
# has 6 as the first entry indicating that this row corresponds to the
# vertex labeled 6. The next entry of this row "141,8200" indicates that
# there is an edge between vertex 6 and vertex 141 that has length 8200.
# The rest of the pairs of this row indicate the other vertices adjacent
# to vertex 6 and the lengths of the corresponding edges.
#
# Your task is
# to run Dijkstra's shortest-path algorithm on this graph, using 1 (the
# first vertex) as the source vertex, and to compute the shortest-path
# distances between 1 and every other vertex of the graph. If there is
# no path between a vertex v and vertex 1, we'll define the
# shortest-path distance between 1 and v to be 1000000.
#
# You should
# report the shortest-path distances to the following ten vertices, in
# order: 7,37,59,82,99,115,133,165,188,197. You should encode the
# distances as a comma-separated string of integers. So if you find that
# all ten of these vertices except 115 are at distance 1000 away from
# vertex 1 and 115 is 2000 distance away, then your answer should be
# 1000,1000,1000,1000,1000,2000,1000,1000,1000,1000. Remember the order
# of reporting DOES MATTER, and the string should be in the same order
# in which the above ten vertices are given. Please type your answer in
# the space provided.

def dijkstra_shortest_path(graph)
  source_vertix = 1
  vertices_processed = [source_vertix]
  shortest_path_distances = {}
  shortest_path_distances[source_vertix] = 0

  while vertices_processed.sort != graph.keys
    shortest = nil
    start_vertix = nil
    end_vertix = nil
    vertices_processed.each do |vertix|
      graph[vertix].each do |edge|
        if !vertices_processed.include?(edge[0])
          if shortest.nil? || shortest_path_distances[vertix] + edge[1] < shortest
            shortest = shortest_path_distances[vertix] + edge[1]
            start_vertix = vertix
            end_vertix = edge[0]
          end
        end
      end
    end
    vertices_processed << end_vertix
    shortest_path_distances[end_vertix] = shortest
  end
  shortest_path_distances
end

if $PROGRAM_NAME == __FILE__

  lines = File.readlines("dijkstraData.txt")
  split_lines = lines.map do |line|
    split_space = line.split
  end

  graph = {}
  split_lines.each do |line|
    graph[line[0].to_i] = line[1..-1]
  end
  graph.keys.each do |key|
    graph[key].map! do |str|
      str.split(",").map do |char|
        char.to_i
      end
    end
  end

  arr = [7,37,59,82,99,115,133,165,188,197]
  shortest_path_distances = dijkstra_shortest_path(graph)
  res = []
  arr.each do |i|
    res << shortest_path_distances[i]
  end
  p res
end
