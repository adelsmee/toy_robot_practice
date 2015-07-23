require 'spec_helper'

module Simulator
  describe Robot do
    before(:each) do
      allow(Simulator::Table).to receive(:has_square?).and_return(true)
    end

    context 'when the robot is not on the table' do
      subject { Robot.new }
      let(:position) { { x: 2, y: 2, direction: 'south' } }

      it 'executes a place command that sits it on the table' do
        subject.place position
        expect(subject.position).to eq(position)
      end

      it 'ignores a place command does not sit it on the table' do
        allow(Simulator::Table).to receive(:has_square?).and_return(false)
        expect(subject.position).to be_nil
      end

      it 'ignores a move command' do
        subject.move
        expect(subject.position).to be_nil
      end

      it 'ignores a turn command' do
        subject.turn 'left'
        expect(subject.position).to be_nil
      end
    end

    context 'when robot is on the table' do
      let(:subject)            { Robot.new.tap { |robot| robot.place(x: position_x, y: position_y, direction: position_direction) } }
      let(:position_x)         { 2 }
      let(:position_y)         { 2 }
      let(:position_direction) { 'north' }

      it 'can turn left' do
        subject.turn 'left'
        expect(subject.position).to eq(x: position_x, y: position_y, direction: 'west')
      end

      it 'can turn right' do
        subject.turn 'right'
        expect(subject.position).to eq(x: position_x, y: position_x, direction: 'east')
      end

      it 'can report current position' do
        expect(subject.report).to eq(x: position_x, y: position_y, direction: position_direction)
      end

      it 'can place an object' do
        subject.place_object
        expect(Table.has_object?(x: position_x, y: position_y + 1)).to be true
      end

      describe 'moving' do
        describe 'to another square on the table' do
          describe 'on the y axis' do
            context 'when facing north' do
              it 'moves up' do
                subject.move
                expect(subject.position).to eq(x: position_x, y: (position_y + 1), direction: position_direction)
              end
            end

            context 'when facing south' do
              let(:position_direction) { 'south' }

              it 'moves down' do
                subject.move
                expect(subject.position).to eq(x: position_x, y: (position_y - 1), direction: position_direction)
              end
            end
          end

          describe 'on the x axis' do
            context 'when facing east' do
              let(:position_direction) { 'east' }

              it 'moves right' do
                subject.move
                expect(subject.position).to eq(x: (position_x + 1), y: position_y, direction: position_direction)
              end
            end

            context 'when facing west' do
              let(:position_direction) { 'west' }

              it 'moves left' do
                subject.move
                expect(subject.position).to eq(x: (position_x - 1), y: position_y, direction: position_direction)
              end
            end
          end
        end

        describe 'off the table' do
          before(:each) do
            allow(Simulator::Table).to receive(:has_square?).and_return(true, false)
          end

          it 'does not move' do
            subject.move
            expect(subject.position).to eq(x: position_x, y: position_y, direction: position_direction)
          end
        end
      end
    end
  end
end
