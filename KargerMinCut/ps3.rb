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

graph = {}
lines = File.readlines("/Users/yi-ke-peng/Documents/MOOCS/AlgorithmsI/kargerMinCut.txt")
split_int_lines = lines.map do |line|
  line.split.map { |char| char.to_i }
end
split_int_lines.each do |line|
  graph[line[0]] = line[1..-1]
end

def kargerMinCut(graph)
  while graph.keys.length > 2
    v1 = graph.keys.sample
    v2 = graph[v1].sample
    e = [v1, v2]
    contract(graph, v1, v2)
  end
  graph[graph.keys[0]].length
end

def contract(graph, v1, v2)
  graph[v2].each do |vertex|
    graph[v1] << vertex if vertex != v1
    graph[vertex].delete(v2)
    graph[vertex] << v1 if vertex != v1
  end
  graph.delete(v2)
end

def deep_copy(o)
  Marshal.load(Marshal.dump(o))
end

graph_copy = deep_copy(graph)

n = graph.length
mincut = n
(n ** 3).times do
  mincut = kargerMinCut(graph_copy) if kargerMinCut(graph_copy) < mincut
end
p mincut
