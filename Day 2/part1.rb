# 12 red cubes, 13 green cubes, and 14 blue cubes
impossible = []
ids = []
max = {"red" => 12, "green" => 13, "blue" => 14}
File.open('input').each do |line|
  id, games = line.split(':')
  id = id[5..].to_i
  ids.push id
  games.split(';').each do |game|
    game.split(',').each do |result|
      h = Hash[*result.strip.split(' ').reverse]
      impossible.push id if h.map {|k, v| v.to_i <= max[k]}.include?(false)
    end
  end
end
p (ids - impossible.uniq).sum

