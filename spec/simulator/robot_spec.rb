require 'spec_helper'

module Simulator
  describe Robot do
    context 'when the robot is not on the table' do
      subject { Robot.new }

      it 'executes a valid PLACE command' do
        subject.place({ x: 2, y: 2, direction: 'south' })
        expect(subject.position).to eq(x: 2, y: 2, direction: 'south')
      end

      it 'ignores a MOVE command' do
        subject.move
        expect(subject.position).to be_nil
      end

      it 'ignores a TURN command' do
        subject.turn 'left'
        expect(subject.position).to be_nil
      end
    end

    context 'when robot is on the table' do
      let(:subject) { Robot.new.tap { |robot| robot.place(x: 2, y: 2, direction: 'south') } }

      it 'can turn left' do
        subject.turn 'left'
        expect(subject.position).to eq(x: 2, y: 2, direction: 'east')
      end

      it 'can turn right' do
        subject.turn 'right'
        expect(subject.position).to eq(x: 2, y: 2, direction: 'west')
      end
    end

  end
end
