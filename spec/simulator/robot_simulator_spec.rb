require 'spec_helper'

module Simulator
  describe RobotSimulator do
    before(:each) do
      STDOUT.stub(:puts)
      allow(robot_commander).to receive(:execute)
      allow(subject).to receive(:print_instructions)
    end

    subject { RobotSimulator.new }
    let(:robot_commander) { double }

    describe '#start' do
      context 'when debug flag is not set' do
        before(:each) do
          allow(subject).to receive(:commander).and_return robot_commander
        end

        context 'with immediate quit' do
          before(:each) do
            STDIN.stub(:gets).and_return('QUIT')
            subject.start
          end

          it 'prints instructions' do
            expect(subject).to have_received(:print_instructions)
          end

          it 'does not pass command to robot' do
            expect(robot_commander).to_not have_received(:execute)
          end
        end

        context 'when command errors' do
          before(:each) do
            STDIN.stub(:gets).and_return('MOVE','QUIT')
            allow(robot_commander).to receive(:execute).and_raise("Bad Things Happened")
            subject.start
          end

          it 'passes command to robot' do
            expect(robot_commander).to have_received(:execute)
          end

          it 'prints error message with no backtrace' do
            expect(STDOUT).to have_received(:puts).with("Bad Things Happened")
          end
        end
      end

      context 'when debug flag is set' do
        describe 'creating robot commander' do
          before(:each) do
            STDIN.stub(:gets).and_return('MOVE','QUIT')
            allow(Command).to receive(:new)
            subject.start true
          end

          it 'sets debug flag on Command' do
            expect(Command).to have_received(:new).with(anything, true)
          end
        end

        context 'when command errors' do
          before(:each) do
            STDIN.stub(:gets).and_return('BITE ME','QUIT')
            allow(subject).to receive(:commander).and_return robot_commander
            allow_any_instance_of(CommandError).to receive(:backtrace)
            allow(robot_commander).to receive(:execute).and_raise CommandError
          end

          it 'prints backtrace' do
            expect_any_instance_of(CommandError).to receive(:backtrace)
            subject.start(true) rescue nil
          end
        end
      end
    end
  end
end
