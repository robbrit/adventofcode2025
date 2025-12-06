grid = []
ops = nil

ARGF.each do |line|
  if line =~ /([*+]\s*)+/
    ops = line.strip.split(/\s+/)
    break
  end

  grid << line.strip.split(/\s+/).map(&:to_i)
end

result = grid.inject do |totals, row|
  ops.each.with_index do |op, col_num|
    if op == "+"
      totals[col_num] += row[col_num]
    else
      totals[col_num] *= row[col_num]
    end
  end
  totals
end

puts result.inject(&:+)
