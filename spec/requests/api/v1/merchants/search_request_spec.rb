require "rails_helper"

describe "merchant search" do
  it "returns the first merchant that fits the search query" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant1.name}"

    merchant = JSON.parse(response.body, symbolize_names: true)
    binding.pry
    expect(response).to be_successful
    expect(merchant[:data][:attributes][:name]).to eq(Merchant.first.name)
  end
end
