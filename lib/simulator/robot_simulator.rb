module Simulator
  class RobotSimulator
    def start debug=false
      @debug = debug
      print_instructions
      simulate
    end

    private

    def simulate
      while true
        begin
          command = $stdin.gets.strip
          break if command.downcase == 'quit'
          result = commander.execute command
          puts result if result
        rescue => e
          puts e.message
          puts e.backtrace if @debug
        end
      end
    end

    def print_instructions
     puts <<-INSTRUCTIONS
       Enter commands to simulate a toy robot moving on a table.
       ******************************************************************************
       Valid commands:
       PLACE 0,0,NORTH - Places the robot on the table at grid coordinates specified.
       Valid grid coordinates 0 - 4. **Note** This must be the first command.
       PLACE_OBJECT - Places an object one square in front of the robot.
       MOVE - Moves the robot forward one square in whichever direction it is facing.
       LEFT - Turns the robot one compass point to the left.
       RIGHT - Turns the robot one compass point to the right.
       REPORT - Prints the current position of the robot in the format
              X_COORDINATE,Y_COORDINATE, FACING_COMPASS_DIRECTION.
       QUIT - Exits the simulation.
     INSTRUCTIONS
    end

    def commander
      @commander ||= Command.new(Robot.new, @debug)
    end
  end
end
