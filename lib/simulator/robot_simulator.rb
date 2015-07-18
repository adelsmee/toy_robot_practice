module Simulator
  class RobotSimulator
    def start
      puts "Enter commands to simulate a toy robot moving on a table"
      while true
        begin
          command = $stdin.gets.strip
          result = commander.execute command
          puts result if result
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
