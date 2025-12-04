
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
  line.chomp!

  case idx
  when 0
    prev = line
    next
  when 1
    this = line
    total += accessible_rolls(nil, prev, line)
    next
  else
    total += accessible_rolls(prev, this, line)
  end

  prev, this = this, line
end

# Process the last row too
total += accessible_rolls(prev, this, nil)

puts total
