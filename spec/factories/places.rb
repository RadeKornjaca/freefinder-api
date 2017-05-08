FactoryGirl.define do
  factory :place do
    name 'Jovan Jovanovic Zmaj'
    lat  45.256896
    lng  19.847872
    association :category
  end
end
