module Simulator
  class CommandError < StandardError; end
end

require 'simulator/command'
require 'simulator/compass'
require 'simulator/robot'
require 'simulator/simulator_cli'
require 'simulator/table'
