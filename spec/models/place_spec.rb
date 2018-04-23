require 'rails_helper'

RSpec.describe Place, type: :model do
  subject do
    @category = FactoryGirl.build(:category)
    described_class.new(id:   1,
                        name: 'Jovan Jovanovic Zmaj',
                        lat:  45.256896,
                        lng:  19.847872,
                        metadata: JSON.parse("{ \"MyString\": \"test_value\" }"),
                        category: @category)
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do

      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without latitude' do
      subject.lat = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without longitude' do
      subject.lng = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations' do
    it { should belong_to(:category) }
  end

  describe '.area' do
    context 'Location in area' do
      before do
        @category = FactoryGirl.build(:category)
        @place = Place.create!(name: 'Jovan Jovanovic Zmaj',
                               lat: 45.256896,
                               lng: 19.847872,
                               metadata: JSON.parse("{ \"MyString\": \"test_value\" }"),
                               category: @category)

        @min_lat = 45
        @max_lat = 45.6
        @min_lng = 19.5
        @max_lng = 20
      end

      it 'should return all the locations in given area bound' do
        expect(Place.area(@min_lat,
                          @max_lat,
                          @min_lng,
                          @max_lng)).to eq [@place]
      end
    end
  end
end
