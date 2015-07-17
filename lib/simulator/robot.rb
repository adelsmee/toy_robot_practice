module Simulator
  class Robot
    def place new_position
      change_position new_position
    end

    def move
    end

    def turn direction
      return unless on_table?
      change_position select_coordinates.merge!(direction: calculate_direction(direction))
    end

    def position
      position_log.last
    end

    private
    def on_table?
      not position_log.empty?
    end

    def change_position new_position
      position_log.push new_position
    end

    def position_log
      @position_log ||= []
    end

    def select_coordinates
      position.select { |key, value| key.to_s.match /x|y/ }
    end

    def current_compass_direction
      position.select { |key, value| key.to_s == 'direction' }[:direction]
    end

    def calculate_direction new_direction
      Compass.rotate(current_compass_direction, new_direction)
    end
  end
end
