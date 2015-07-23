module Simulator
  class Command
    def initialize robot, debug=false
      @robot = robot
      @debug = debug
    end

    def execute command
      command = command.downcase
      response = ''

      case command
        when 'move', 'place_object'
          @robot.send command
        when 'report'
          response = format_report @robot.send(command)
        when 'left', 'right'
          @robot.turn command
        when /^place /
          @robot.place validate_place_args(extract_place_args(command))
        else
          raise CommandError.new "Unknown command '#{command.upcase}'"
      end
      return [response, @robot.position].reject { |item| item.nil? || item == '' } if @debug
      return response unless response.empty?
    end

    private

    def format_report position
      "#{position[:x]},#{position[:y]},#{position[:direction].upcase}"
    end

    def validate_place_args args
      args_hash = {}

      begin
        args_hash = parse_place_args args
        validate_coordinates args_hash[:x], args_hash[:y]
        validate_direction args_hash[:direction]
      rescue => e
        raise CommandError.new "Invalid PLACE '#{args.upcase}'. #{e.message}"
      end

      args_hash
    end

    def validate_coordinates x_coordinate, y_coordinate
      unless Table.has_square? x: x_coordinate, y: y_coordinate
        raise "Coordinates (#{x_coordinate},#{y_coordinate}) are off the table"
      end
    end

    def validate_direction direction
      unless Compass::DIRECTIONS.include? direction
        raise "'#{direction.upcase}' is not an allowed compass direction"
      end
    end

    def parse_place_args args
      values = args.split(',')
      { x: Integer(values[0]), y: Integer(values[1]), direction: values[2] }
    end

    def extract_place_args place_command
      place_command.split(' ')[1..-1].join(' ')
    end
  end
end
