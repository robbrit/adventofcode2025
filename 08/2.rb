boxes = ARGF.map { |line| line.chomp.split(",").map(&:to_i) }

# Since we typically only care about the minimum, it would be more efficient to use a heap
distances = []

boxes.each.with_index do |(x1, y1, z1), i|
  ((i+1)...boxes.length).each do |j|
    x2, y2, z2 = boxes[j]
    dist_sq = (x1 - x2)**2 + (y1 - y2)**2 + (z1 - z2)**2
    distances << [dist_sq, [i, j]]
  end
end

distances.sort_by!(&:first)

# It would be more efficient to use a proper disjoint set data structure, but this will do in a pinch
memberships = (0...boxes.length).to_a
num_groups = memberships.length

distances.each do |_, (i, j)|
  next if memberships[i] == memberships[j] # They're already in the same set

  mi, mj = memberships[i], memberships[j]

  if mi < mj
    new_set, old_set = mi, mj
  else
    new_set, old_set = mj, mi
  end

  memberships.each.with_index do |value, idx|
    memberships[idx] = new_set if value == old_set
  end

  num_groups -= 1
  puts boxes[i][0] * boxes[j][0] and break if num_groups == 1
end
