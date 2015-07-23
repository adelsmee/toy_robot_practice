require 'spec_helper'

module Simulator
  describe Table do
    before(:each) do
      Table.reset!
    end

    context 'map' do
      it 'returns the entire table grid' do
        expect(Table.map).to eq([[0] * Table::WIDTH] * Table::HEIGHT)
      end
    end

    context 'has_square?' do
      it 'returns true for existing square' do
        expect(Table.has_square?(x: 1, y: 1)).to be true
      end

      it 'returns false for non-existent square' do
        expect(Table.has_square?(x: -1, y: -1)).to be false
      end
    end

    context 'has_object?' do
      it 'returns false if object is not present at coordinates' do
        expect(Table.has_object?(x: 1, y: 2)).to be false
      end
    end

    context 'place_object' do
      it 'places an object on the specified coordinates' do
        Table.place_object x: 3, y: 3
        expect(Table.has_object?(x: 3, y: 3)).to be true
      end
    end
  end
end
