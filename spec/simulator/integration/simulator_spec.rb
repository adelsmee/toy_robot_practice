require 'spec_helper'

module Simulator
  describe 'SimulatorIntegration' do
    before(:each) do
      STDOUT.stub(:puts)
    end

    let(:simulator) { RobotSimulator.new }

    it 'does basic move and report' do
      STDIN.stub(:gets).and_return('PLACE 0,0,NORTH', 'MOVE', 'REPORT', 'QUIT')
      simulator.start
      expect(STDOUT).to have_received('puts').with('0,1,NORTH')
    end

    it 'does place object and map' do
      STDIN.stub(:gets).and_return('PLACE 1,1,NORTH', 'PLACE_OBJECT', 'MAP', 'QUIT')
      simulator.start
      expect(STDOUT).to have_received('puts').with("00000\n00000\n0X000\n00000\n00000")
    end
  end
end
