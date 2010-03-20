#!/usr/bin/env ruby

# Implementation of the quadratic map based on this
# web page by Paul Bourke:
# http://local.wasp.uwa.edu.au/~pbourke/fractals/lyapunov/

class QuadraticMap
  attr_accessor :x, :y, :ax, :ay, :num_runs, :steps, :xmax, :xmin, :ymax, :ymin, :xe, :ye,
  :dx, :dy, :xenew, :yenew, :itr, :lya, :dd, :d0
  def initialize num_runs = 10000, steps = 10000
    @num_runs = num_runs
    @steps = steps
  end

  def simulate
    num_runs.times do
      run_once
      if chaotic?
        print_values
        break
      end
    end
  end

  def run_once
    setup_new_run
    (steps-1).times do
      update_values
      break if divergent? or convergent?
      update_exponent
    end
  end

  def setup_new_run
    @x = []
    @y = []
    x << zap_with_noise
    y << zap_with_noise

    @ax = []
    @ay = []
    6.times do
      ax << zap_with_noise
      ay << zap_with_noise
    end

    reset_values
  end

  def reset_values
    @itr = 0
    @xmin = 1e32
    @xmax = -1e32
    @ymin = 1e32
    @ymax = -1e32
    @lya = 0.0
    @d0 = 0.0
    until @d0 > 0 do
      @xe = x[0] + zap_with_noise/1000.0
      @ye = y[0] + zap_with_noise/1000.0
      @dx = x[0] - xe
      @dy = y[0] - ye
      @d0 = Math.sqrt( dx*dx + dy*dy )
    end
  end

  def update_values
    @x.push(ax[0] + ax[1]*x[itr] + ax[2]*x[itr]*x[itr] + ax[3]*x[itr]*y[itr] + ax[4]*y[itr] + ax[5]*y[itr]*y[itr])
    @y.push(ay[0] + ay[1]*x[itr] + ay[2]*x[itr]*x[itr] + ay[3]*x[itr]*y[itr] + ay[4]*y[itr] + ay[5]*y[itr]*y[itr])
    @xenew = ax[0] + ax[1]*xe + ax[2]*xe*xe + ax[3]*xe*ye + ax[4]*ye + ax[5]*ye*ye
    @yenew = ay[0] + ay[1]*xe + ay[2]*xe*xe + ay[3]*xe*ye + ay[4]*ye + ay[5]*ye*ye
    @xmin = [xmin, x[itr]].min
    @ymin = [ymin, y[itr]].min
    @xmax = [xmax, x[itr]].max
    @ymax = [ymax, y[itr]].max
    @dx = x[itr+1] - x[itr]
    @dy = y[itr+1] - y[itr]
    @itr += 1
  end

  def zap_with_noise
    plus_or_minus = rand
    if plus_or_minus > 0.5
      return -(rand)
    else
      return rand
    end
  end

  def divergent?
    if xmin < -1e10 or ymin < -1e10 or xmax > 1e10 or ymax > 1e10
      return true
    end
    false
  end

  def convergent?
    if dx.abs < 1e-10 or dy.abs < 1e-10
      return true
    end
    false
  end

  def enough_steps?
    return itr > 1000
  end
  
  def update_exponent
    if enough_steps?
      @dx = x[itr] - xenew
      @dy = y[itr] - yenew
      @dd = Math.sqrt( dx*dx + dy*dy )
      @lya += Math.log( (dd/d0).abs )
      @xe = x[itr] + d0*dx/dd
      @ye = y[itr] + d0*dy/dd
    end
  end

  def chaotic?
    return lya > 10
  end

  def print_values
    x.each_with_index do |val, i|
      str = ""
      str << val.to_s << "\t" << y[i].to_s
      puts str
    end
  end
end

map = QuadraticMap.new
map.simulate
