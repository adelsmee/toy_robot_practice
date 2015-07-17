module Simulator
  class Table
    class << self

      def has_square? coordinates
        return false if grid[coordinates[:x]].nil? || grid[coordinates[:x]][coordinates[:y]].nil?
        true
      end

      private

      def grid
        @grid ||= [[0] * 5] * 5
      end

    end
  end
end
