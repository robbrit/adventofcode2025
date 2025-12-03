class Integer
  def invalid_id?
    size = Math.log10(self).floor + 1
    return false if size % 2 == 1  # Odd sized numbers can't be invalid
    radix = 10**(size / 2)

    self / radix == self % radix
  end
end

sum = 0

while next_pair = ARGF.gets(",")
  next unless next_pair =~ /(\d+)-(\d+)/

  lo, hi = $1.to_i, $2.to_i

  sum += (lo..hi).
    select(&:invalid_id?).
    inject(&:+) || 0
end

puts sum
