total = 0
joltage_size = 12

ARGF.each do |line|
  line.chomp!

  current_maxes = [0] * joltage_size

  line.each_char.with_index do |c, i|
    as_int = c.to_i

    # Find the first spot in the current maxes where this current character replaces it
    start_idx = [0, joltage_size - line.length + i].max # Clip for when we're near the end

    first_to_adjust = (start_idx...joltage_size).find { |j| as_int > current_maxes[j] }
    next unless first_to_adjust  # Nothing found, ignore this character

    # Replace the tail of the current max with this character and zeroes
    current_maxes[first_to_adjust] = as_int
    ((first_to_adjust+1)...joltage_size).each do |j|
      current_maxes[j] = 0
    end
  end

  total += current_maxes.inject { |s, c| s * 10 + c }
end

puts total
