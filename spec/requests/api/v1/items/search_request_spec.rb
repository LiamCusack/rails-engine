require "rails_helper"

describe "item search" do
  it "returns the first item that fits the search query" do
    item1 = create(:item)
    item2 = create(:item)

    get "/api/v1/items/find?name=#{item1.name}"

    item = JSON.parse(response.body, symbolize_names: true)
    binding.pry
    expect(response).to be_successful
    expect(item[:data][:attributes][:name]).to eq(Merchant.first.name)
  end
end
