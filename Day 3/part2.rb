    engine = File.read('input').split("\n")
    gears = []
    parts = []
    engine.each_with_index do |line, lineno|
      line.enum_for(:scan, /\*/).each do |i|
        gears << [i, lineno, Regexp.last_match.begin(0)]
      end
      line.enum_for(:scan, /[0-9]+/).each do |i|
        parts << [i, lineno, Regexp.last_match.begin(0)]
      end
    end
    # determine which parts are adjacent to each gear
    ratio = 0
    gears.each do |_, gline, gpos|
      adj = []
      parts.each do |s, pline, ppos|
        adj << s.to_i if  (pline - gline).abs <= 1 && gpos.between?(ppos - 1, ppos + s.length)
      end
      ratio += adj[0] * adj[1] if adj.length == 2
    end
    p ratio