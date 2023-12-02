pow = []

File.open('input').each do |line|
  _, games = line.split(':')
  max = {}
  games.split(';').each do |game|
    game.split(',').each do |result|
      h = Hash[*result.strip.split(' ').reverse]
      h.each {|k, v| max[k] = [v.to_i, max[k] || 0].max}
     end
  end
  pow.push max.values.inject(:*)
end
p pow.sum

