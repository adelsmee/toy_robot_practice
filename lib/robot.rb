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

    def select_direction
      position.select { |key, value| key.to_s == 'direction' }
    end

    def calculate_direction direction
      turn_map[select_direction[:direction].to_sym][direction.to_sym]
    end

    def turn_map
      {
        :north =>
          {left: 'west', right: 'east'},
        :south =>
          {left: 'east', right: 'west'},
        :east =>
          {left: 'north', right: 'south'},
        :west =>
          {left: 'south', right: 'north'}
      }
    end
  end
end
