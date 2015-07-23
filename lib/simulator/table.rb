module Simulator
  class Table
    class << self
      OBJECT_MARKER = 'X'

      def has_square? coordinates
        if coordinates[:x] < 0        ||
           coordinates[:y] < 0        ||
           grid[coordinates[:x]].nil? ||
           grid[coordinates[:x]][coordinates[:y]].nil?
          return false
        end
        true
      end

      def place_object coordinates
        grid[coordinates[:x]][coordinates[:y]] = OBJECT_MARKER
      end

      def has_object? coordinates
        return (grid[coordinates[:x]][coordinates[:y]] == OBJECT_MARKER)
      end
      private

      def grid
        @grid ||= [[0] * 5] * 5
      end

    end
  end
end
