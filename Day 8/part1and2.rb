  ins, map = File.read('input.txt').split("\n\n")

  graph = map.scan(/[A-Z]+/).each_slice(3).map{|label, l, r| [label, l, r]}
  ins = ins.chars

  def traverse(graph, ins, startex, endex)
    initial = graph.select{|label, _, _| label =~ startex}
    initial.map do |node|
      steps = 0
      while node[0] !~ endex do
        steps += 1
        direction = ins[steps%ins.length-1] == 'L' ? 1 : 2
        node = graph.find {|label, _, _| label == node[direction]}
      end
      steps
    end
  end

  # part 1
  p traverse(graph, ins, /AAA/, /ZZZ/)[0]
  # part 2
  p traverse(graph, ins, /..A/, /..Z/).reduce(1, :lcm)