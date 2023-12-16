layout = File.read('input.txt').split("\n").map{|l| l.chars}

def beam(level, map, row, col, direction, visited)
  # encode all the movements, e.g., going right and encounter '.' => just keep going right
  movements = {
    right:  {'.': :right,  '/': :up,     '\\': :down,  '|': [:up, :down], '-': :right},
    left:   {'.': :left,   '/': :down,   '\\': :up,    '|': [:up, :down], '-': :left},
    up:     {'.': :up,     '/': :right,  '\\': :left,  '|': :up,          '-': [:left, :right]},
    down:   {'.': :down,   '/': :left,   '\\': :right, '|': :down,        '-': [:left, :right]},
  }

  while col >= 0 and col < map[0].length and row >= 0 and row < map.length
    # already passed this point going in this direction, 
    # no need to push on
    break if visited.include?([row, col, direction])
    visited.add [row, col, direction]

    direction = movements[direction][map[row][col].to_sym]
    case direction
    when :up
      row = row-1
    when :down
      row = row+1
    when :left
      col = col-1
    when :right
      col = col+1
    when [:up, :down]
      # go down plus new beam up
      beam(level+1, map, row-1, col, :up, visited)
      direction = :down
      row = row+1 
    when [:left, :right]
      # go right plus new beam left
      beam(level+1, map, row, col-1, :left, visited)
      direction = :right
      col = col+1 
    end
  end
  return visited.map{|r,c,d| [r,c]}.uniq.count if (level == 0)
end

# part 1
p beam(0, layout, 0, 0, :right, Set.new)

# part 2 fast enough to just brute force it
rows = 0..layout.length - 1
cols = 0..layout[0].length - 1
p [
  rows.map{|r| beam(0, layout, r, cols.first, :right, Set.new)}.max,
  rows.map{|r| beam(0, layout, r, cols.last, :left, Set.new)}.max,
  cols.map{|c| beam(0, layout, rows.first, c, :down, Set.new)}.max,
  cols.map{|c| beam(0, layout, rows.last, c, :up, Set.new)}.max
].max
