require 'thor'

module Simulator
  class SimulatorCLI < Thor

    desc 'start', 'Starts the robot simulator'
    # option :debug, :type => :boolean
    def start
      Simulate.new.start
    end

    default_task :start

  end
end
