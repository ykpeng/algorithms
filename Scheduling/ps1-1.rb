def schedule_jobs(weights, lengths, number_of_jobs)
  differences = {}
  (0...number_of_jobs).each do |i|
    differences[i] = weights[i] - lengths[i]
  end
  ordered_jobs = differences.sort_by { |key, value| [value, weights[key]] }.reverse.to_h.keys
end

def weighted_completion_times_sum(ordered_jobs, weights, lengths)
  current_length = 0
  sum = 0
  ordered_jobs.each do |i|
    current_length += lengths[i]
    sum += weights[i] * current_length
  end
  p sum
end

if $PROGRAM_NAME == __FILE__
  lines = File.readlines("jobs.txt")
  number_of_jobs = lines[0].to_i

  weights = {}
  lengths = {}
  lines[1..-1].each_with_index do |line, idx|
    weights[idx] = line.split[0].to_i
    lengths[idx] = line.split[1].to_i
  end
  ordered_jobs = schedule_jobs(weights, lengths, number_of_jobs)
  weighted_completion_times_sum(ordered_jobs, weights, lengths)
end
