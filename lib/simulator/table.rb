module Simulator
  class Table
    OBJECT_MARKER = 'X'
    WIDTH = 5
    HEIGHT = 5

    class << self

      def has_square? coordinates
        if coordinates[:x] < 0      ||
           coordinates[:y] < 0      ||
           coordinates[:x] >= WIDTH ||
           coordinates[:y] >= HEIGHT
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

      def map
        grid
      end

      def reset!
        @grid = [[0] * WIDTH] * HEIGHT
      end

      private

      def grid
        @grid ||= [[0] * WIDTH] * HEIGHT
      end

    end
  end
end
