universe = File.read('input.txt').split("\n")

galaxies = []
expandy = []
expandx = []

# original universe galaxy positions + y positions to be expanded
universe.each.with_index do |l, row|
  positions = l.enum_for(:scan, /#/).map { Regexp.last_match.begin(0) }
  galaxies += positions.map{|col| [row, col]}
  expandy.push(row) if positions.empty?
end

# x positions to be expanded
(0..universe[0].length-1).each do |col|
  expandx.push(col) if universe.map {|x| x[col]}.uniq == ['.']
end

# perform expansion of universe by modifing galaxy positions accordingly
def doexpansion(galaxies, expandy, expandx, factor)
   galaxies.map do |y, x|
    ny = expandy.select{|e| e <= y}.count
    nx = expandx.select{|e| e <= x}.count
    [y + (ny * (factor - 1)), x + (nx * (factor - 1))]
  end
end

[2, 1000000].map do |f|
  r = doexpansion(galaxies, expandy, expandx, f).combination(2).map do |g1, g2|
    # chessboard distance calculation between two galaxies
    (g1[0] - g2[0]).abs + (g1[1] - g2[1]).abs
  end
  p r.sum
end
