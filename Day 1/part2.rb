r = []
map = {
  "one" => 1,
  "two" => 2, 
  "three" => 3,
  "four" => 4, 
  "five" => 5, 
  "six" => 6, 
  "seven" => 7,
  "eight" => 8,
  "nine" => 9
}

File.open('input.txt').each do |line|
  first = line.scan(Regexp.new("[1-9]|#{map.keys.join('|')}"))[0]
  first = map[first] || first.to_i
  last = line.reverse.scan(Regexp.new("[1-9]|#{map.keys.join('|').reverse}"))[0].reverse
  last = map[last] || last.to_i
  r.push first * 10 + last
end
p r.sum