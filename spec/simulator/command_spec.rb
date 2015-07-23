require 'spec_helper'

module Simulator
  describe Command do
    before(:each) do
      allow(robot).to receive(:place)
      allow(robot).to receive(:move)
      allow(robot).to receive(:turn)
      allow(robot).to receive(:place_object)
      allow(robot).to receive(:report).and_return(x: 1, y: 1, direction: 'north')
      allow(robot).to receive(:position).and_return(x: 2, y: 2, direction: 'east')
      allow(Table).to receive(:map).and_return([[0] * 2] * 2)
    end

    subject     { Command.new(robot) }
    let(:robot) { instance_double(Robot) }

    describe 'execute' do
      context 'when command is valid' do
        ['MOVE','REPORT','PLACE_OBJECT'].each do |command|
          it "sends #{command} command to object" do
            expect(robot).to receive(command.downcase.to_sym)
            subject.execute command
          end
        end

        ['LEFT','RIGHT'].each do |command|
          it "converts #{command} to turn command and sends to object with correct direction" do
            expect(robot).to receive(:turn).with(command.downcase)
            subject.execute command
          end
        end

        it 'sends PLACE command to object with correct position' do
          expect(robot).to receive(:place).with(x: 0, y: 0, direction: 'north')
          subject.execute "PLACE 0,0,NORTH"
        end

        it 'formats REPORT response' do
          expect(subject.execute('REPORT')).to eq '1,1,NORTH'
        end


        it 'formats MAP response' do
          expect(subject.execute('MAP')).to eq "00\n00"
        end
      end

      context 'when command is invalid' do
        it 'returns error message when command is unknown' do
          expect { subject.execute('FIRE LASERS') }.to raise_error CommandError,
                                                                   "Unknown command 'FIRE LASERS'"
        end

        it 'returns error message when invalid coordinates are supplied with PLACE command' do
          expect { subject.execute('PLACE 6,9,SOUTH') }.to raise_error CommandError,
                                                                   "Invalid PLACE '6,9,SOUTH'. "\
                                                                   "Coordinates (6,9) are off the table"
        end

        it 'returns error message when invalid compass direction is supplied with PLACE command' do
          expect { subject.execute('PLACE 1,2,SOUTH-EAST') }.to raise_error CommandError,
                                                                   "Invalid PLACE '1,2,SOUTH-EAST'. "\
                                                                   "'SOUTH-EAST' is not an allowed compass direction"
        end
      end
    end

    context 'when debug flag is set' do
      subject { Command.new(robot, true) }

      it 'prints position after command is executed' do
        expect(subject.execute('MOVE')).to include(x: 2, y: 2, direction: 'east')
      end
    end
  end
end
