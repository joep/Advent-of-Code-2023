data = File.read('input.txt')

# initialize the modules.
def initstate(txt)
  modules = txt
    .split("\n")
    .map{_1.split(' -> ')}
    .map{{("%&".include?(_1[0]) ? _1[1..] : _1) =>
      {type: _1[0], state: _1[0] == '&' ? {} : false, targets: _2.split(', ')}}}
    .reduce({}, :merge)

  # initialize memory of conjuntion modules
  modules.each do |m, v|
    v[:targets].each do |k|
      next if not modules[k] 
      modules[k][:state][m] = false if modules[k][:type] == '&'
    end
  end

  modules
end

def pulse(from, to, signal, modules, q)
  return if not modules[to]
  case modules[to][:type]
  when '&'
    # conjunction
    # remember signal from this input
    modules[to][:state][from] = signal
    # sends high signal by default
    # UNLESS all signals from remembered inputs are high, then low
    signal = modules[to][:state].values.uniq == [true] ? false : true
  when '%'
    # flip flop
    # high pulse does nothing
    return if signal
    # low pulse flips state and sends current state
    modules[to][:state] = !modules[to][:state]
    signal = modules[to][:state]
  when 'b'
    # broadcaster
  end
  modules[to][:targets].each {
    # print to.to_s, " ", signal ? "-high" : "-low" , " -> ", _1, "\n"
    q.push [to, _1, signal]
  }
end

def run(txt, cnt, name)
  # part 1
  modules = initstate(txt)
  q = []
  cnthigh = 0
  cntlow = 0
  presses = 0

  cnt.times do
    presses += 1
    # count the initial pulse of button press to broadcaster!
    cntlow += 1
    pulse(nil, 'broadcaster', false, modules, q)
    while not q.empty?
      from, to, signal = q.shift
      signal ? cnthigh += 1 : cntlow += 1
      pulse(from, to, signal, modules, q)
      return presses if name and to == name and signal == false
    end
  end
  return cntlow*cnthigh
end

# part 1
p run(data, 1000, nil)

# Hmmmmm...part 2
# Brute force running the loop doesn't work because it takes too long.
# Instead, notice that rx receives its input from only cx, which is a 
# conjuntion module that receives its input from four sources: kh,
# lz, tg, and hn. In order for cx to go low and output a low to
# rx, all four of the inputs to cx must go low. Let's look...

#p run(data, 5000, "kh")
#p run(data, 5000, "lz")
#p run(data, 5000, "tg")
#p run(data, 5000, "hn")

# So each of the four inputs goes low on a cycle. In order for all four
# of them to be low at the same time, they need to align, which happens
# at the lowest common multiple for all of them. Thanks to reddit
# for the hint on how to do all this. Doubt I would have figured it
# out on my own.

p [
    run(data, 5000, "kh"),
    run(data, 5000, "lz"),
    run(data, 5000, "tg"),
    run(data, 5000, "hn")
  ].reduce(1, :lcm)
