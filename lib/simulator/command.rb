module Simulator
  class Command
    def initialize robot
      @robot = robot
    end

    def execute command
      case command.downcase!.strip!
        when 'move', 'report'
          @robot.send command
        when 'left', 'right'
          @robot.turn command
        when /^place/
          args = parse_place_args(extract_place_args(command))
          byebug
          @robot.place args
      end
    end

    private
    def parse_place_args args
      values = args.split(',')
      { x: values[0], y: values[1], direction: values[2] }
    end

    def extract_place_args place_command
      place_command.split(' ')[1..-1].join(' ')
    end
  end
end
