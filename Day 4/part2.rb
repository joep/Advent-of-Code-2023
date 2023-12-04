    h = {}

    File.open('input').each do |line|
      parts = line.split(/[:|]/)
      game = parts[0].scan(/[0-9]+/)[0]
      winners = parts[1].scan(/[0-9]+/)
      results = parts[2].scan(/[0-9]+/)
      h[game.to_i] = {winners: winners, results: results}
    end

    cards = h.keys
    total_cards = 0
    cards.each do |card|
      total_cards += 1
      next_card_to_get = card + 1
      h[card][:results].each do |result|
        if h[card][:winners].include?(result)
          cards.push next_card_to_get
          next_card_to_get += 1
        end
      end
    end

    p total_cards