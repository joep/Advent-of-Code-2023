r = []
File.open('calibration').each do |line|
  nums = line.scan(/[1-9]/)
  r.push nums.first.to_i * 10 + nums.last.to_i
end
p r.sum