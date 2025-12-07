start_row = ARGF.gets
grid_width = start_row.length

# Track the number of paths that have led to each position.
possible_tachyons = [0] * grid_width
possible_tachyons[start_row.index('S')] = 1

ARGF.each do |line|
  row = line.chomp.chars
  new_possibilities = [0] * grid_width
  possible_tachyons.each.with_index do |count, idx|
    case row[idx]
    when '.'
      # Just passing through, nothing to see here people
      new_possibilities[idx] += count
    when '^'
      new_possibilities[idx-1] += count
      new_possibilities[idx+1] += count
    end
  end
  possible_tachyons = new_possibilities
end

puts possible_tachyons.inject(&:+)
