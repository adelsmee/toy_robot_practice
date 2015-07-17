require 'spec_helper'

module Simulator
  describe Compass do
    context 'when rotating left' do
      let(:direction) { 'left' }

      [
        ['north','west'],
        ['west','south'],
        ['south','east'],
        ['east','north']
      ].each do |from_compass_point, to_compass_point|
        it 'moves to correct compass direction' do
          expect(Compass.rotate(from_compass_point, direction)).to eq to_compass_point
        end
      end
    end

    context 'when rotating right' do
      let(:direction) { 'right' }

      [
        ['north','east'],
        ['west','north'],
        ['south','west'],
        ['east','south']
      ].each do |from_compass_point, to_compass_point|
        it 'moves to correct compass direction' do
          expect(Compass.rotate(from_compass_point, direction)).to eq to_compass_point
        end
      end
    end
  end
end
