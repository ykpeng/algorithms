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
  graph.keys.reverse_each do |i|
    stack = [i]
    tracker.current_source = i
    while !stack.empty?
      v = stack.last
      if !tracker.explored.include?(v)
        dfs(graph, stack, v, tracker)
      else
        if tracker.finishing_times[v] == nil
          tracker.leaders[v] = tracker.current_source
          tracker.current_time += 1
          tracker.finishing_times[v] = tracker.current_time
        end
        stack.pop
      end
    end
  end
end

def dfs(graph, stack, v, tracker)
  tracker.explored << v
  # tracker.leaders[v] = tracker.current_source
  if graph[v] == nil
    tracker.leaders[v] = v
    tracker.current_time += 1
    tracker.finishing_times[v] = tracker.current_time
    stack.pop
  else
    graph[v].each do |w|
      if !tracker.explored.include?(w)
        stack << w
      end
    end
  end
end

def scc(original_graph, graph_rev, tracker, tracker2)
  dfs_loop(graph_rev, tracker)
  # p tracker.finishing_times
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
