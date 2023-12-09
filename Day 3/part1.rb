    engine = File.read('input.txt').split("\n")
    # surround entire engine schematic with '.' to eliminate all annoying edge cases.
    engine.unshift '.' * engine[0].length
    engine.push '.' * engine[0].length
    engine.each.each_with_index do |line, lineno|
      engine[lineno] = '.' + line + '.'
    end
    okparts = []
    engine.each_with_index do |line, lineno|
      # determine all engine part numbers and their position in the line
      positions = line.enum_for(:scan, /[0-9]+/).map { [Regexp.last_match.to_s, Regexp.last_match.begin(0)] }
      # collect all engine numbers that are adjacent to symbols
      positions.each do |partnum, position|
        c = ''
        c << engine[lineno - 1].slice(position - 1..position + partnum.length)
        c << line[position - 1]
        c << line[position + partnum.length]
        c << engine[lineno + 1].slice(position - 1..position + partnum.length)
        okparts.push partnum.to_i if not c.scan(/[^\.]/).empty?
      end
    end
    p okparts.sum