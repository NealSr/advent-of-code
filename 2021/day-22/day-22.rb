require 'set'

Cube = Struct.new(:xmin, :xmax, :ymin, :ymax, :zmin, :zmax) do
  def to_s
    "(#{xmin}, #{xmax}, #{ymin}, #{ymax}, #{zmin}, #{zmax})"
  end
  def valid?
    xmin < xmax && ymin < ymax && zmin < zmax
  end
  def intersection(cube)
    Cube.new(
      [xmin, cube.xmin].max,
      [xmax, cube.xmax].min,
      [ymin, cube.ymin].max,
      [ymax, cube.ymax].min,
      [zmin, cube.zmin].max,
      [zmax, cube.zmax].min
    )
  end
  def intersect?(cube)
    intersection(cube).valid?
  end
  def volume
    (xmax - xmin) * (ymax - ymin) * (zmax - zmin)
  end
end

input = File.readlines(if ARGV[0] == "test" then "sample.txt" else "input.txt" end)

reactor_on = Set[]
min, max = -50, 50

reactor_state = {}

fit_cube = -> new_cube, to_add {
  reactor_state.keys.each do |cube|
    next unless new_cube.intersect?(cube)
    reactor_state.delete(cube)
    xs = [cube.xmin, cube.xmax, new_cube.xmin, new_cube.xmax].uniq.sort
    ys = [cube.ymin, cube.ymax, new_cube.ymin, new_cube.ymax].uniq.sort
    zs = [cube.zmin, cube.zmax, new_cube.zmin, new_cube.zmax].uniq.sort
    xs.each_cons(2) do |x1, x2|
      ys.each_cons(2) do |y1, y2|
        zs.each_cons(2) do |z1, z2|
          target_cube = Cube.new(x1,x2,y1,y2,z1,z2)
          reactor_state[target_cube] = true if to_add[target_cube, cube]
        end
      end
    end
  end
}

for line in input do
  action = line.split(" ")[0]
  xyz = line.split(" ")[1].split(",")
  xmin = xyz[0].split("=")[1].split("..")[0].to_i
  xmax = xyz[0].split("=")[1].split("..")[1].to_i+1
  ymin = xyz[1].split("=")[1].split("..")[0].to_i
  ymax = xyz[1].split("=")[1].split("..")[1].to_i+1
  zmin = xyz[2].split("=")[1].split("..")[0].to_i
  zmax = xyz[2].split("=")[1].split("..")[1].to_i+1

  new_cube = Cube.new(xmin,xmax,ymin,ymax,zmin,zmax)
  fit_cube[new_cube, -> slice, old_cube { old_cube.intersect?(slice) && !new_cube.intersect?(slice) }]
  reactor_state[new_cube] = true if action == "on"

  if xmin >= min && ymin >= min && zmin >= min && xmax <= max && ymax <= max && zmax <= max then
    for x in xmin..xmax do
      for y in ymin..ymax do
        for z in zmin..zmax do
          if action == "on" then
            reactor_on << [x,y,z]
          else
            reactor_on.delete([x,y,z])
          end
        end
      end
    end
  puts reactor_on.length
  end
end

pp reactor_state.keys.sum(&:volume)