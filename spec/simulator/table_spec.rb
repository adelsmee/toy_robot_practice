require 'spec_helper'

module Simulator
  describe Table do
    context 'has_square?' do
      it 'returns true for existing square' do
        expect(Table.has_square?(x: 1, y: 1)).to be true
      end

      it 'returns false for non-existent square' do
        expect(Table.has_square?(x: -1, y: -1)).to be false
      end
    end
  end
end
