map = File.read('input.txt').split("\n")
nodes = {}
start = [0, 0]

map.each.with_index do |l, y|
  travel = {
    'S' => [:north, :south, :east, :west],
    'F' => [:south, :east],
    'J' => [:north, :west],
    'L' => [:north, :east],
    '7' => [:south, :west],
    '|' => [:north, :south],
    '-' => [:east, :west],
    '.' => []
  }
  nodes[y] = {}
  l.chars.each.with_index do |c, x|
    start = [y,x] if c == 'S'
    nodes[y][x] = {label: c, travel: travel[c], visited: false}
  end
end

def traverse(y, x, nodes, circuit)
  return if nodes[y][x][:visited]
  nodes[y][x][:visited] = true
  travel = nodes[y][x][:travel]
  circuit << traverse(y-1, x, nodes, circuit) if travel.include?(:north)
  circuit << traverse(y+1, x, nodes, circuit) if travel.include?(:south)
  circuit << traverse(y, x+1, nodes, circuit) if travel.include?(:east)
  circuit << traverse(y, x-1, nodes, circuit) if travel.include?(:west)
  [y,x]
end

circuit = [[start[0], start[1]]]
traverse(start[0], start[1], nodes, circuit)
circuit = circuit.compact

# Part 1 is just 1/2 the circuit length
p circuit.count / 2

# Part 2
count = 0
(0..map[1].length-1).each do |y|
  parity = 0
  (0..map[0].length-1).each do |x|
    if nodes[y][x][:visited]
     if 'S|LJ'.include?(nodes[y][x][:label])
        parity += 1
      end
    else
     count += 1 if parity.odd?
    end
  end
end
p count