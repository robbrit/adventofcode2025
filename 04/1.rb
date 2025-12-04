# Algorithm:
# Scan through the lines of the map, looking for accessible cells.
# We only need the previous, current, and next rows to determine which cells are accessible, so we
# discard any older rows as we read through the map.

# Get the number of accessible rolls in `this` row.
def accessible_rolls prev, this, succ
  total = 0

  this.each_char.with_index do |c, i|
    next unless c == "@"

    min_x = i == 0 ? i : i - 1
    max_x = i == this.length - 1 ? i : i + 1

    count = 0
    (min_x..max_x).each do |x|
      count += 1 if prev != nil and prev[x] == "@"
      count += 1 if x != i and this[x] == "@"
      count += 1 if succ != nil and succ[x] == "@"
    end

    total += 1 if count < 4
  end
  total
end

prev, this = nil, nil
total = 0

ARGF.each.with_index do |line, idx|
  # We don't process each line when we see it, instead we store it and then process it when
  # we see the next line.
  line.chomp!

  # On the first row we just store it and move on.
  this = line and next if idx == 0

  total += accessible_rolls(prev, this, line)
  prev, this = this, line
end

# We still have to do the last line.
total += accessible_rolls(prev, this, nil)

puts total
