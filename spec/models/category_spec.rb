require 'rails_helper'

RSpec.describe Category, type: :model do
  before do
    @category = FactoryGirl.build(:category)
  end


  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(@category).to be_valid
    end

    it 'is not valid without a name' do
      @category.name = nil
      expect(@category).to_not be_valid
    end
  end
end
