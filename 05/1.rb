state = :fresh
ranges = []  # A binary interval tree would be more efficient here but an array is simple
fresh_count = 0

ARGF.each do |line|
  case state
  when :fresh
    state = :spoiled and next if line =~ /^\s*$/
    next unless line =~ /^(\d+)-(\d+)/
    a, b = $1.to_i, $2.to_i
    ranges << Range.new(a, b)
  when :spoiled
    id = line.chomp.to_i
    fresh_count += 1 if ranges.any? { |r| r.include? id }
  end
end

puts fresh_count
