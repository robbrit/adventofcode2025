start_row = ARGF.gets

# Figure out where all the tachyons are in the first row.
tachyon_idxs = Set[start_row.index('S')]

splits = 0
ARGF.each do |line|
  row = line.chomp.chars
  new_idxs = Set.new
  tachyon_idxs.each do |idx|
    case row[idx]
    when '.'
      # Just passing through, nothing to see here people
      new_idxs << idx
    when '^'
      splits += 1
      new_idxs << idx - 1
      new_idxs << idx + 1
    end
  end
  tachyon_idxs = new_idxs
end

puts splits
