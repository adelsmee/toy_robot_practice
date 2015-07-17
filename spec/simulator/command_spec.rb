require 'spec_helper'

module Simulator
  describe Command do
    before(:each) do
      allow(robot).to receive(:place)
      allow(robot).to receive(:move)
      allow(robot).to receive(:turn)
      allow(robot).to receive(:report)
    end

    subject     { Command.new(robot) }
    let(:robot) { double }

    describe 'execute' do
      context 'when command is valid' do
        ['MOVE','REPORT'].each do |command|
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

        # formats reports
      end

      # context 'when command is invalid' do
      #   it 'returns "command unknown" message' do
      #   end

      #   describe 'without required information' do
      #     it 'returns error message' do
      #     end
      #   end
      # end
    end
  end
end
