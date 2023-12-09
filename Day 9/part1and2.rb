history = File.read('input.txt').split("\n").map{_1.scan(/[-]?[0-9]+/).map(&:to_i)}

#
# original solution...
#
def oldcalculate(line)
  # only interested in the last value in each reduction
  newval = line.last
  while line.uniq != [0]
    line = line.each_cons(2).map{_2 - _1}
    newval += line.last
  end
  newval
end

#
# but I like this one better...
#
def calculate(line)
  line.uniq == [0] ? 0 : line.last + calculate(line.each_cons(2).map{_2 - _1})
end

# part 1
p history.map {|l| calculate(l)}.sum
# part 2
p history.map {|l| calculate(l.reverse)}.sum