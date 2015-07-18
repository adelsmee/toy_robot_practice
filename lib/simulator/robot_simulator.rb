module Simulator
  class RobotSimulator
    def start
      puts "Enter commands to simulate a toy robot moving on a table"
      while true
        begin
          command = $stdin.gets.strip
          puts commander.execute command
        rescue => e
          puts e.message
          puts e.backtrace
        end
      end
    end

    def commander
      @commander ||= Command.new(Robot.new)
    end
  end
end
