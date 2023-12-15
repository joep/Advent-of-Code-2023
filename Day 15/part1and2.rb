sequence = File.read('input.txt').split(',')

# part 1
def hash(s)
  s.chars.reduce(0){ (_1 + _2.ord) * 17 % 256 }
end

p sequence.map{hash(_1)}.sum

# part 2
# Fortunately Ruby will keep the ordering of hashes for us
#
boxes = {}
(0..255).each{|i| boxes[i] = {}}

sequence.each do |step|
  if step.chars.last == '-'
    label = step[0..-2]
    boxes[hash(label)].delete(label)
  else
    label, lens = step.split('=')
    boxes[hash(label)][label] = lens.to_i
  end
end

p boxes.map{|no, lenses|
  (no + 1) * lenses.each_with_index.map{|s,i| (i+1) * s[1]}.sum
}.sum