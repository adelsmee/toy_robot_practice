module Simulator
  class Compass
    DIRECTIONS = ['north','east','south','west']

    class << self

      def rotate(from, direction)
        current_index = DIRECTIONS.find_index from
        direction_index = convert_direction_to_index direction
        new_index = current_index + direction_index

        if new_index >= 0 && DIRECTIONS[new_index]
          return DIRECTIONS[new_index]
        elsif new_index < 0
          return DIRECTIONS.last
        else
          return DIRECTIONS.first
        end
      end

      private

      def convert_direction_to_index str_direction
        (str_direction == 'left') ? -1 : 1
      end
    end
  end
end
