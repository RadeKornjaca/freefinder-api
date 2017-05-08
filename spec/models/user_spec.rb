require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(email: 'john@doe.com',
                        password: 'johndoe')
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without an email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations' do
    it { should have_many(:api_keys) }
  end
end
