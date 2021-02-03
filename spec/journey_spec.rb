require 'journey'

describe Journey do
  describe 'in_journey?' do
    it 'initially not in jouney' do
      expect(subject).not_to be_in_journey
    end
  end
end