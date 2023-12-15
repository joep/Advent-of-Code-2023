input = File.read('input.txt').split("\n").map{|l| l.chars}

def roll(a)
  a = a.dup
  a.each.with_index do |r, i|
    pattern = /(O)([\.]+)/
    line = r.reverse.join
    while line.match?(pattern) do
      line = line.gsub(pattern, '\2\1')
    end
    a[i] = line.chars.reverse
  end
end

def load(a)
  a.each_with_index.map{|r, i| (a.size-i)*r.count('O')}.sum
end

# part 1
p load(roll(input.transpose).transpose)

def spin(a)
  # roll only works for west, so transpose each direction so it looks like
  # it needs to spin west
  a = a.dup
  a = roll(a.transpose).transpose # north
  a = roll(a) # west
  a = roll(a.transpose.map{|l| l.reverse}).transpose.reverse # south
  a = roll(a.map{|l| l.reverse}).map{|l| l.reverse} # east
end

# part 2
history = {}
loopcnt = 1000000000
cyclestart = cyclelength = steps = 0
(1..loopcnt).each do |i|
  input = spin(input)
  d = input.map{|r| r.join}.join
  # Have I seen this output arrangement before?
  if history[d]
    # Yes! It is just going to repeat from here on out.
    # So just calculate the last cyclelength steps and we are done
    cyclestart = history[d]
    cyclelength = i - cyclestart
    steps = (loopcnt - cyclestart) % cyclelength
    break
  end
  history[d] = i
end

(1..steps).each do |i|
  input = spin(input)
end
p load(input)