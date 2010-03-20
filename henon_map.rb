#!/usr/bin/env ruby

def henon_map
  steps = 10000
  a = 1.4
  b = 0.3
  x = 0.631354477
  y = 0.189406343
  
  steps.times do
    x = y + 1 - a*x*x
    y = b*x
    print x.to_s << "\t" << y.to_s << "\n"
  end
  
end

henon_map
