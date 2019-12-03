RSpec.describe CallCenterAvailability do
  before do
    Timecop.freeze(Time.new(2019, 12, 3, 21))
  end

  after do
    Timecop.return
  end

  describe '#available?' do
    subject(:call_center_availability) do
      CallCenterAvailability.new(time)
    end

    context 'when is operating hours' do
      context 'when is working week' do
        let(:time) { Time.new(2019, 12, 6, 11) }

        it 'returns true' do
          expect(call_center_availability).to be_available
        end
      end

      context 'when is less than 2 hours current moment' do
        before do
          Timecop.freeze(Time.new(2019, 12, 4, 9, 30))
        end

        after do
          Timecop.return
        end

        let(:time) { 2.hours.from_now - 1.minute }

        it 'returns false' do
          expect(call_center_availability).to_not be_available
        end
      end

      context 'when is more than 2 hours from current moment' do
        before do
          Timecop.freeze(Time.new(2019, 12, 4, 9, 30))
        end

        after do
          Timecop.return
        end

        let(:time) { 2.hours.from_now + 1.minute }

        it 'returns false' do
          expect(call_center_availability).to be_available
        end
      end

      context 'when is Saturday' do
        let(:time) { Time.new(2019, 12, 7, 12) }

        it 'returns true' do
          expect(call_center_availability).to be_available
        end
      end

      context 'when is less than six working days' do
        let(:time) { Time.new(2019, 12, 11, 12, 30) }

        it 'returns true' do
          expect(call_center_availability).to be_available
        end
      end

      context 'when is more than six working days' do
        let(:time) { Time.new(2019, 12, 12, 12) }

        it 'returns false' do
          expect(call_center_availability).to_not be_available
        end
      end
    end

    context 'when is not operating hours' do
      context 'when is Sunday' do
        let(:time) { Time.new(2019, 12, 8, 13) }

        it 'returns false' do
          expect(call_center_availability).to_not be_available
        end
      end

      context 'when is Saturday' do
        let(:time) { Time.new(2019, 12, 7, 12, 31) }

        it 'returns false' do
          expect(call_center_availability).to_not be_available
        end
      end

      context 'when is working week' do
        let(:time) { Time.new(2019, 12, 5, 20, 31) }

        it 'returns false' do
          expect(call_center_availability).to_not be_available
        end
      end
    end
  end
end
