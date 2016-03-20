# The file contains the adjacency list representation of a simple
# undirected graph. There are 200 vertices labeled 1 to 200. The first
# column in the file represents the vertex label, and the particular row
# (other entries except the first column) tells all the vertices that
# the vertex is adjacent to. So for example, the 6th row looks like : "6
#	155	56	52	120	......". This just means that the vertex with label 6
# is adjacent to (i.e., shares an edge with) the vertices with labels
# 155,56,52,120,......,etc
#
# Your task is to code up and run the randomized contraction algorithm
#for the min cut problem and use it on the above graph to compute the
# min cut (i.e., the minimum-possible number of crossing edges).
# (HINT: Note that you'll have to figure out an implementation of edge
# contractions. Initially, you might want to do this naively, creating
# a new graph from the old every time there's an edge contraction. But
# you should also think about more efficient implementations.)
# (WARNING: As per the video lectures, please make sure to run the
# algorithm many times with different random seeds, and remember the
# smallest cut that you ever find.)
include Math

nodes = {}
lines = File.readlines("/Users/yi-ke-peng/Documents/MOOCS/AlgorithmsI/kargerMinCut.txt")
split_int_lines = lines.map do |line|
  line.split.map { |char| char.to_i }
end
split_int_lines.each do |line|
  nodes[line[0]] = line[1..-1]
end

edges = {}
i = 0
nodes.each_key do |vertex|
  nodes[vertex].each do |v2|
    if v2 > vertex
      edges[i] = [vertex, v2]
      i += 1
    end
  end
end

def kargerMinCut(nodes, edges)
  while nodes.length > 2
    rand_edge = edges.keys.sample
    v1 = edges[rand_edge][0]
    v2 = edges[rand_edge][1]
    contract(nodes, edges, v1, v2)
    # p nodes
    # p edges
  end
  nodes[nodes.keys[0]].length
end

def contract(nodes, edges, v1, v2)
  nodes[v2].each do |vertex|
    if vertex != v1
      nodes[v1] << vertex
      nodes[vertex] << v1
    end
    nodes[vertex].delete(v2)
  end
  nodes.delete(v2)
  edges.each_key do |edge|
    if edges[edge].include?(v2)
      edges[edge].delete(v2)
      edges[edge] << v1
    end
  end
  edges.delete_if { |edge, vertices| vertices[0] == vertices[1] }
end

def deep_copy(o)
  Marshal.load(Marshal.dump(o))
end

n = nodes.length
mincut = n
4000.times do
  nodes_copy = deep_copy(nodes)
  edges_copy = deep_copy(edges)
  # kargerMinCut(nodes_copy, edges_copy)
  mincut = kargerMinCut(nodes_copy, edges_copy) if kargerMinCut(nodes_copy, edges_copy) < mincut
end
p mincut
