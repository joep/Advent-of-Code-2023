    h = {}

    File.open('input').each do |line|
      parts = line.split(/[:|]/)
      game = parts[0].scan(/[0-9]+/)[0].to_i
      winners = parts[1].scan(/[0-9]+/)
      results = parts[2].scan(/[0-9]+/)
      h[game] = (winners & results).count
    end

    cards = h.keys
    cards.each do |game|
      h[game].times { |index| cards.push game + index + 1}
    end

    p cards.count