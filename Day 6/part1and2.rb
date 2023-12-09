times, distances = File.read('input.txt')
  .split("\n")
  .map{|l| l.scan(/[0-9]+/)}
  .map{|i| i.map(&:to_i)}
races = times.zip(distances)

def solve(time, distance)
  # controlling equation for puzzle: 
  #   (time - n) * n = distance
  # where n = button press time
  #
  # solve for n:
  #   (time - n) * n = distance
  #   time * n - n**2 = distance
  #  -time * n + n**2 = -distance
  #   n**2 - time * n + distance = 0
  # this is just a quadratic equation, ax^2+bx+c = 0
  # where a = 1, b = -time, c = distance
  # solution n = (-b+-sqrt(b^2-4ac))/2a
  #
  # so the roots give us upper and lower bounds for n
  # and the number of solutions is integer range between them
  #
  a = 1; b = -time; c = distance
  r1 = (-b + Math.sqrt(b**2-4 * a * c))/2 * a
  r2 = (-b - Math.sqrt(b**2-4 * a * c))/2 * a
  return r1.ceil - r2.floor - 1
end

# part 1
p races.map{|t, d| solve(t, d)}.reduce(:*)
# part 2
p solve(times.join.to_i, distances.join.to_i)