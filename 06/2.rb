class Integer
  def num_digits
    Math.log10(self+1).ceil
  end
end

grid = []
max_digits = nil
ops = nil

# Parse the input: extract rows, determine column widths
ARGF.each do |line|
  if line =~ /([*+]\s*)+/
    ops = line.strip.split(/\s+/)
    break
  end

  grid << line.chomp

  row = line.strip.split(/\s+/).map(&:to_i)

  max_digits ||= [0] * row.length
  lengths = row.map(&:num_digits)
  max_digits = max_digits.zip(lengths).map(&:max)
end

transposed_grid = max_digits.map { |i| [] }

# Iterate across each column in the text grid and extract the number that is there
col_num = 0        # What column are we parsing?
col_start_idx = 0  # Where does the current column start?
while col_start_idx < grid[0].length
  width = max_digits[col_num]

  (0...width).each do |i|
    num = 0
    found_digit = false
    (0...grid.length).each do |row_idx|
      c = grid[row_idx][col_start_idx + i]
      if c == " "
        break if found_digit
        next
      end

      num = num * 10 + c.to_i
    end
    transposed_grid[col_num] << num
  end

  col_start_idx += width + 1
  col_num += 1
end

result = transposed_grid.map.with_index do |row, i|
  if ops[i] == "+"
    row.inject(&:+)
  else
    row.inject(&:*)
  end
end

puts result.inject(&:+)
