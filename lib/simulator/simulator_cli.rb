require 'thor'

module Simulator
  class SimulatorCLI < Thor

    desc 'start', 'Starts the robot simulator'
    option :debug, :type => :boolean
    def start
      RobotSimulator.new.start options[:debug]
    end

    default_task :start
  end
end
