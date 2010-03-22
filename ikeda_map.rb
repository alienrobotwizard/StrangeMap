#!/usr/bin/env ruby

def ikeda_map
  steps = 100000
  u = 0.9

  x = 0.0
  y = 0.0

  steps.times do
    x_old = x
    t = 0.4 - 6/(1 + x*x + y*y)
    x = 1 + u*( x*Math.cos(t) - y*Math.sin(t) )
    y = u*( x_old*Math.sin(t) + y*Math.cos(t) )
    puts [x,y,t].join("\t") + "\n"
  end
end

ikeda_map
