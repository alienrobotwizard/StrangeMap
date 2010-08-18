#!/usr/bin/env ruby

require 'rubygems'
require 'gnuplot'

# Canonical henon map, dude.

#
# Generate points from the henon map starting at
# coordinates (x,y) and stepping forward n iterations
#
def henon_map n, x, y, &blk
  xn = [x,y]
  n.times{ yield xn = henon(*xn) }
end

# one step
def henon(x,y)
  [y + 1 - 1.4*x*x, 0.3*x]
end

#
# Boring plotting routine
#
Gnuplot.open do |gp|
  Gnuplot::Plot.new(gp) do |plot|
    plot.data << Gnuplot::DataSet.new([]) do |ds|
      henon_map(10000, 0.631354477, 0.189406343){|pt| ds.data << pt.join("\t")}
    end
  end
end
