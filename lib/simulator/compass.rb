module Simulator
  class Compass
    class << self

      def rotate(from, direction)
        current_index = compass.find_index from
        direction_index = convert_direction_to_index direction
        new_index = current_index + direction_index

        if new_index >= 0 && compass[new_index]
          return compass[new_index]
        elsif new_index < 0
          return compass.last
        else
          return compass.first
        end
      end

      private

      def convert_direction_to_index str_direction
        (str_direction == 'left') ? -1 : 1
      end

      def compass
        @compass ||= ['north','east','south','west']
      end
    end
  end
end
