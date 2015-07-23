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
        return unless has_square? coordinates
        grid[coordinates[:y]][coordinates[:x]] = OBJECT_MARKER
      end

      def has_object? coordinates
        return (grid[coordinates[:y]][coordinates[:x]] == OBJECT_MARKER)
      end

      def map
        grid.reverse
      end

      def reset!
        @grid = grid_array
      end

      private

      def grid
        @grid ||= grid_array
      end

      def grid_array
        grid = [[0] * 5] * 5
        grid.map! { |item| item.clone }
      end

    end
  end
end
