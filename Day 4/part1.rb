    points = 0

    File.open('input').each do |line|
      parts = line.split(/[:|]/)
      winners = parts[1].scan(/[0-9]+/)
      results = parts[2].scan(/[0-9]+/)

      n = (results & winners).count
      points += n > 0 ? 2 ** (n - 1) : 0
    end

    p points