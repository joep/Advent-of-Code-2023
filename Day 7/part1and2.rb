hands = File.read('input.txt').split("\n").map{|h| h.split(" ")}

# part 1
p hands
  .map {|h| 
    # To each hand, we add two values, the rank, which
    # is represented by an array in the form, e.g.,
    # [3, 2] or [4, 1] or [2, 2, 1] or [2, 1, 1, 1],
    # representing a full house, four of a kind, two pair, or
    # one pair, respectively. The second value is the lexographic
    # value, mapped to the 'vals' array and results in 
    # an array of numbers, e.g.  "9TT93" = [7, 8, 8, 7, 1].
    vals = [*(2..9).map{_1.to_s}, 'T', 'J', 'Q', 'K', 'A']
    h += [
      h[0].chars.tally.values.sort.reverse,
      h[0].chars.map{|c| vals.index(c)}
    ]
  }
  # Ruby sorts these two arrays for us.
  .sort {|a, b| [a[2], a[3]] <=> [b[2], b[3]]}
  # Sum it all up according to the rules.
  .each_with_index.map{|h, i| (i+1) * h[1].to_i}.sum

# part 2
# same as part 1, but with jokers accounted for according to rules
p hands
  .map {|h| 
    vals = ['J', *(2..9).map{_1.to_s}, 'T', 'Q', 'K', 'A']
    h += [
      lambda {
        hand = h[0]
        if hand.include?('J')
          highest = hand.delete('J').chars.tally.max_by{|k,v| v}
          highest = highest ? highest[0] : h[0][0]
          hand = hand.gsub('J', highest)
          # p h[0] + ' -> ' + hand
        end
        hand.chars.tally.values.sort.reverse
      }.call,
      h[0].chars.map{|c| vals.index(c)}
    ]
  }
  .sort {|a, b| [a[2], a[3]] <=> [b[2], b[3]]}
  .each_with_index.map{|h, i| (i+1) * h[1].to_i}.sum