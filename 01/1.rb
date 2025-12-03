count = 0
position = 50

ARGF.each do |line|
  next unless line =~ /^(L|R)(\d+)/

  sign = if $1 == "L" then -1 else 1 end
  value = $2.to_i

  position = (position + value * sign) % 100
  count += 1 if position == 0
end

puts count
