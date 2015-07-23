module Simulator
  class Robot
    def place new_position
      new_coordinates = select_xy new_position
      change_position new_position if Table.has_square? new_coordinates
    end

    def move
      return unless on_table?

      new_coordinates = calculate_coordinates
      change_position new_coordinates.merge!(direction: current_compass_direction) if Table.has_square? new_coordinates
    end

    def turn direction
      return unless on_table?

      change_position current_coordinates.merge!(direction: calculate_direction(direction))
    end

    def position
      position_log.last
    end

    alias_method :report, :position

    def place_object
      Table.place_object calculate_coordinates
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

    def current_coordinates
      select_xy position
    end

    def calculate_coordinates
      current_position = current_coordinates
      new_position_key = current_compass_direction.match(/north|south/) ? 'y' : 'x'
      new_position_offset = current_compass_direction.match(/north|east/) ? 1 : -1
      new_position_value = current_position[new_position_key.to_sym] + new_position_offset
      current_position.merge! new_position_key.to_sym => new_position_value
    end

    def select_xy position_hash
      position_hash.select { |key, value| key.to_s.match /x|y/ }
    end

    def current_compass_direction
      position.select { |key, value| key.to_s == 'direction' }[:direction]
    end

    def calculate_direction new_direction
      Compass.rotate(current_compass_direction, new_direction)
    end
  end
end
