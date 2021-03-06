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
        it "moves from #{from_compass_point} to #{to_compass_point}" do
          expect(Compass.rotate(from_compass_point, direction)).to eq to_compass_point
        end
      end
    end

    context 'when rotating right' do
      let(:direction) { 'right' }

      [
        ['north','east'],
        ['east','south'],
        ['south','west'],
        ['west','north']
      ].each do |from_compass_point, to_compass_point|
        it "moves from #{from_compass_point} to #{to_compass_point}" do
          expect(Compass.rotate(from_compass_point, direction)).to eq to_compass_point
        end
      end
    end
  end
end
