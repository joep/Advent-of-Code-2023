    engine = File.read('input').split("\n")
    # surround entire engine schematic with '.' to eliminate all annoying edge cases.
    engine.unshift '.' * engine[0].length
    engine.push '.' * engine[0].length
    engine.each.each_with_index do |line, lineno|
      engine[lineno] = '.' + line + '.'
    end
    gear = {}
    engine.each_with_index do |line, lineno|
      # determine all engine part numbers and their position in the line
      positions = line.enum_for(:scan, /[0-9]+/).map { [Regexp.last_match.to_s, Regexp.last_match.begin(0)] }
      # create a hash with each gear and collect all the engine parts that are adjacent
      positions.each do |partnum, position|
        c = ''
        (lineno - 1..lineno + 1).each do |i|
          c << engine[i].slice(position - 1..position + partnum.length)
        end
        gears = c.enum_for(:scan, /\*/).map { [Regexp.last_match.to_s, Regexp.last_match.begin(0)] }
        gears.each do |g|
          l = lineno + (g[1]/(partnum.length+2)-1)
          p = position + (g[1]%(partnum.length+2)-1)
          gear["#{l.to_s+','+p.to_s}"] ||= []
          gear["#{l.to_s+','+p.to_s}"] << partnum.to_i
        end
      end
    end
    ratio = 0
    gear.each do |k, v|
      # only a gear that has EXACTLY two adjacent parts get counted
      if v.length == 2
        ratio += v[0] * v[1]
      end
    end
    p ratio

