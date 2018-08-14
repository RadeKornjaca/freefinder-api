require 'rails_helper'

RSpec.describe PlacesController, type: :controller do
  before do
    @request.env['Authorization'] = "8f5b62a4bf10f9b52ea2d6563aa35bcc"
  end

  it "returns a single place" do
    category = FactoryGirl.build(:category)
    place = FactoryGirl.create(:place)
    get :show, format: :json
    json = JSON.parse(last_response.body)
    expect(json["data"]["id"]).to eq(1)
  end
end
