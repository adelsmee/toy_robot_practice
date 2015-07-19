module Simulator
  class Table
    class << self

      def has_square? coordinates
        if coordinates[:x] < 0        ||
           coordinates[:y] < 0        ||
           grid[coordinates[:x]].nil? ||
           grid[coordinates[:x]][coordinates[:y]].nil?
          return false
        end
        true
      end

      private

      def grid
        @grid ||= [[0] * 5] * 5
      end

    end
  end
end
