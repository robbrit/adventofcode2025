total = 0

ARGF.each do |line|
  line.chomp!

  first = 0
  second = 0
  line.each_char.with_index do |c, i|
    as_int = c.to_i

    if as_int > first and i < line.length - 1
      first = as_int
      second = 0
    elsif as_int > second
      second = as_int
    end
  end

  total += first * 10 + second
end

puts total
