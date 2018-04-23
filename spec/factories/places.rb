FactoryGirl.define do
  factory :place do
    name        'Jovan Jovanovic Zmaj'
    lat         45.256896
    lng         19.847872
    metadata    '"test_key": "test_value"' 
    association :category
  end
end
