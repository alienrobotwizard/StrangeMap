#!/usr/bin/env ruby

require 'rubygems'
require 'gnuplot'

#
# Generate points from the henon map starting at
# coordinates (x,y) and stepping forward n iterations
#
def henon_map n, x, y, &blk
  a, b = [1.4, 0.3] # parameters defining how the map behaves
  n.times{x_n = x; yield [x = y + 1 - a*x*x, y = b*x_n]}
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
