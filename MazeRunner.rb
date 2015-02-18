class Array
  def p(pt)
    self[pt[:y]][pt[:x]]
  end
end


maze = []
start_point = {}


File.foreach ('maze1.txt') do |line|
  maze.push(line.split(//))
end

discovered = Array.new(maze.length) { Array.new(maze[0].length, false) }
parents = Array.new(maze.length) { Array.new(maze[0].length, nil) }


# find start

maze.each_with_index do |line, l_index|
  line.each_with_index do |obj, o_index|
    start_point = {x: o_index, y: l_index} if obj == "S"
  end
end

proc_queue = [start_point]
p start_point
discovered[start_point[:y]][start_point[:x]] = 1


def wewin(new_point, maze, parents)
  win_maze = maze.clone
  draw_point = (new_point)
  until parents[draw_point[:y]][draw_point[:x]] == nil
    win_maze[draw_point[:y]][draw_point[:x]] = "X"
    draw_point = parents[draw_point[:y]][draw_point[:x]]
  end
  win_maze.each do |line|
    puts line.join("")
  end
end


loop do
  current_point = proc_queue.shift
  [{x:0,y:1},{x:1,y:0},{x:0,y:-1},{x:-1,y:0}].each do |dirvector|
    new_point = {x: current_point[:x] + dirvector[:x], y: current_point[:y] + dirvector[:y]}
    if maze[new_point[:y]][new_point[:x]] = "E"
      parents[new_point[:y]][new_point[:x]] = current_point
      wewin(new_point, maze, parents)
      break
    end
    if !discovered[new_point[:y]][new_point[:x]] and maze[new_point[:y]][new_point[:x]] = " "
      discovered[new_point[:y]][new_point[:x]] = discovered[current_point[:y]][current_point[:x]] + 1
      parents[new_point[:y]][new_point[:x]] = current_point
      proc_queue.push(new_point)
    end
  end
end
