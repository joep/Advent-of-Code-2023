    points = []

    File.open('input').each do |line|
      parts = line.split(/[:|]/)
      game = parts[0].scan(/[0-9]+/)
      winners = parts[1].scan(/[0-9]+/)
      results = parts[2].scan(/[0-9]+/)

      total = 0
      results.each do |result|
        total = total == 0 ? 1 : total * 2 if winners.include?(result)
      end
      points.push total
    end

    p points.sum