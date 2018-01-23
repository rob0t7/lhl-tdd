require 'rails_helper'

RSpec.describe Brewery, type: :model do
  describe '.all_in_ascending_order' do
    it 'returns all the records by name in ascending order' do
      brewery1 = FactoryBot.create(:brewery, name: 'Brewery B')
      brewery2 = FactoryBot.create(:brewery, name: 'Brewery A')

      subject = Brewery

      expect(
        subject.all_in_ascending_order
      ).to eq([brewery2, brewery1])
    end
  end

  describe '#valid' do
    subject { FactoryBot.build(:brewery) }

    it 'is expect to be valid by default' do
      expect(subject).to be_valid
    end

    it 'is invalid without a name' do
      subject.name = ''
      expect(subject).to be_invalid
    end
  end
end
