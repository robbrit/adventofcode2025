# Algorithm:
# Until no more cells are removed:
#   loop across each row of the map, determining the ones that are accessible
#   remove the accessible ones

# Get the accessible rolls in `this` row.
def accessible_rolls prev, this, succ
  accessible = []

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

    accessible << i if count < 4
  end
  accessible
end

# Remove any accessible rolls from the map, returning the number of rolls removed.
def remove_rolls map
  (0...map.length).map do |y|
    accessible_rolls(
      y == 0 ? nil : map[y-1],
      map[y],
      y == map.length - 1 ? nil : map[y+1],
    )
  end.each.with_index.reduce(0) do |total_removed, (row, y)|
    row.each do |x|
      map[y][x] = "."
    end
    total_removed + row.length
  end
end

map = ARGF.map(&:chomp)

total = 0
loop do
  num_removed = remove_rolls(map)
  break if num_removed == 0
  total += num_removed
end

puts total
