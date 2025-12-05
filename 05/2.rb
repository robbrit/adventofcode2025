$ranges = []  # A binary interval tree or even a linked list would be more efficient here but an array is simple

# Insert the new range into the existing collection of ranges, performing any range merges as necessary.
def push_range r
  # Find the index where this one should get inserted
  insert_idx = (0...$ranges.length).find { |i| $ranges[i].end >= r.begin - 1 }

  # Edge case: Nowhere to insert, so it goes at the end
  $ranges << r and return if insert_idx.nil?

  current = $ranges[insert_idx]

  # Edge case: New range doesn't overlap with the next one, just shift it in
  $ranges.insert(insert_idx, r) and return if r.end < current.begin - 1

  # We need to merge this range with the current, and potentially an arbitrary number of others
  new_begin = [current.begin, r.begin].min
  new_end = [current.end, r.end].max

  # Now we'll replace all the ranges that overlap with the new range
  cut_until = ((insert_idx+1)...$ranges.length).find { |j| $ranges[j].begin > new_end + 1 } || $ranges.length
  # Edge case: the last one we overlap with extends beyond our new range
  new_end = $ranges[cut_until - 1].end if $ranges[cut_until - 1].end > new_end
  $ranges[insert_idx...cut_until] = [Range.new(new_begin, new_end)]
end

ARGF.each do |line|
  break if line =~ /^\s*$/  # In this one we don't care about the stuff after the ID ranges.
  next unless line =~ /^(\d+)-(\d+)/
  push_range Range.new($1.to_i, $2.to_i)
end

# Now we have a sequence of disjoint ranges, we can compute the number of valid IDs
puts $ranges.map(&:size).inject(:+)
