# The file contains the edges of a directed graph. Vertices are labeled
# as positive integers from 1 to 875714. Every row indicates an edge,
# the vertex label in first column is the tail and the vertex label in
# second column is the head (recall the graph is directed, and the edges
# are directed from the first column vertex to the second column vertex).
# So for example, the 11th row looks liks : "2 47646". This just means
# that the vertex with label 2 has an outgoing edge to the vertex with
# label 47646
#
# Your task is to code up the algorithm from the video lectures for
# computing strongly connected components (SCCs), and to run this
# algorithm on the given graph.
#
# Output Format: You should output the sizes of the 5 largest SCCs in
# the given graph, in decreasing order of sizes, separated by commas
# (avoid any spaces). So if your algorithm computes the sizes of the
# five largest SCCs to be 500, 400, 300, 200 and 100, then your answer
# should be "500,400,300,200,100". If your algorithm finds less than 5
# SCCs, then write 0 for the remaining terms. Thus, if your algorithm
# computes only 3 SCCs whose sizes are 400, 300, and 100, then your
# answer should be "400,300,100,0,0".
require 'set'

class Tracker
  attr_accessor :explored, :current_source, :leaders, :current_time,
  :finishing_times

  def initialize
    @explored = Set.new
    #track current source vertex
    @current_source = nil
    @leaders = {}
    #track finishing times/ number of nodes processed so far
    @current_time = 0
    @finishing_times = {}
  end
end

def dfs_loop(graph, tracker)
  graph.keys.reverse_each do |node|
    #if i not yet explored
    if !tracker.explored.include?(node)
      tracker.current_source = node
      dfs(graph, node, tracker)
    end
  end
end

def dfs(graph, i, tracker)
  #mark i as explored
  tracker.explored << i
  #set leader(i) = node $s
  tracker.leaders[i] = tracker.current_source
  #for each arc (i, j), if j not explored
  if graph[i] == nil
    tracker.leaders[i] = i
  else
    graph[i].each do |j|
      if !tracker.explored.include?(j)
        dfs(graph, j, tracker)
      end
    end
  end
  # increment $t
  tracker.current_time += 1
  #set f(i) = $t
  tracker.finishing_times[i] = tracker.current_time
end

def scc(original_graph, graph_rev, tracker, tracker2)
  dfs_loop(graph_rev, tracker)
  p tracker.finishing_times
  sorted_graph = Hash[original_graph.sort_by { |k, v| tracker.finishing_times[k] }]
  dfs_loop(sorted_graph, tracker2)
end

if $PROGRAM_NAME == __FILE__
  lines = File.readlines("test1.txt")
  split_int_lines = lines.map do |line|
    line.split.map { |char| char.to_i }
  end

  original_graph = {}
  split_int_lines.each do |line|
    original_graph[line[0]] = []
  end
  split_int_lines.each do |line|
    original_graph[line[0]] << line[1]
  end

  graph_rev = {}
  split_int_lines.each do |line|
    graph_rev[line[1]] = []
  end
  split_int_lines.each do |line|
    graph_rev[line[1]] << line[0]
  end
  graph_rev = Hash[graph_rev.sort]

  # p original_graph
  # p graph_rev

  tracker = Tracker.new
  tracker2 = Tracker.new
  scc(original_graph, graph_rev, tracker, tracker2)

  frequencies = Hash.new(0)
  tracker2.leaders.each do |k, v|
    frequencies[v] += 1
  end

  p frequencies.values.sort.reverse[0, 5]
end
