FactoryGirl.define do
  factory :category do
    name              'Monument'    
    additional_fields [FactoryGirl.build(:additional_field)] 
  end
end
