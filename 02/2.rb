class Integer
  def invalid_id?
    size = Math.log10(self).floor + 1

    (1..(size / 2)).each do |i|
      next if size % i != 0  # The number's size is not a multiple of this radix
      radix = 10**i

      repeat = self % radix
      current = self / radix
      found_mismatch = false
      while current > 0
        found_mismatch = true and break if current % radix != repeat
        current /= radix
      end
      return true unless found_mismatch
    end

    false
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
