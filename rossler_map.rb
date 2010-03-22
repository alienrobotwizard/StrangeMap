#!/usr/bin/env ruby

def zap_with_noise
  plus_or_minus = rand
  if plus_or_minus > 0.5
    return -(rand)
  else
    return rand
  end
end

def rossler_map
  steps = 100000
  a = 0.15
  b = 0.20
  c = 10.0
  dt = 0.001

  #set initial conditions
  x = zap_with_noise
  y = zap_with_noise
  z = zap_with_noise
  
  steps.times do
    x_old = x
    x = x - dt*( y + z )
    y = y + dt*( x_old + a*y )
    z = z + dt*( b + z*( x_old - c ) )
    puts [x,y,z].join("\t") + "\n"
  end
end

rossler_map
