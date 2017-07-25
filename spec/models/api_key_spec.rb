require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  subject do
    @user = FactoryGirl.build(:user)
    described_class.new(access_token: SecureRandom.hex,
                        user: @user)
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

#    it 'is not valid without an access token' do
#      subject.access_token = nil
#      expect(subject).to_not be_valid
#    end
  end

  describe 'Associations' do
    it { should belong_to(:user) }
  end
end
