count = 0
position = 50

ARGF.each do |line|
  next unless line =~ /^(L|R)(\d+)/

  dir = if $1 == "L" then -1 else 1 end
  value = $2.to_i

  while value > 0
    position = (position + dir) % 100
    count += 1 if position == 0
    value -= 1
  end
end

puts count
