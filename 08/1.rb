#num_connections = 10
num_connections = 1000
n_largest = 3

boxes = ARGF.map { |line| line.chomp.split(",").map(&:to_i) }

# Since we typically only care about the minimum, it would be more efficient to use a heap
distances = []
# It would be more efficient to use a proper disjoint set data structure, but this will do in a pinch
memberships = (0...boxes.length).to_a

boxes.each.with_index do |(x1, y1, z1), i|
  ((i+1)...boxes.length).each do |j|
    x2, y2, z2 = boxes[j]
    dist_sq = (x1 - x2)**2 + (y1 - y2)**2 + (z1 - z2)**2
    distances << [dist_sq, [i, j]]
  end
end

distances.sort_by!(&:first)

num_connections.times do |conn_idx|
  _, (i, j) = distances[conn_idx]
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
end

groups = memberships.tally.to_a.sort_by(&:last)

puts groups[-n_largest..].map(&:last).inject(&:*)
