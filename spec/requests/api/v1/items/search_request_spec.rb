require "rails_helper"

describe "item search" do
  it "returns all items that fit the search" do
    item1 = create(:item)
    item2 = create(:item)

    get "/api/v1/items/find_all?name=#{item1.name}"

    items = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(items[:data].count).to eq(2)

    items[:data].each do |item|
      expect(item[:attributes][:name]).to eq("MyString")
    end
  end

  it "sadpath no fragment given" do
    get "/api/v1/items/find_all?name="

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data]).to be_an(Array)
    expect(items[:data].count).to eq(0)
  end

  it "sadpath no fragment matched" do
    get "/api/v1/items/find_all?name=notanactualitem"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data]).to be_an(Array)
    expect(items[:data].count).to eq(0)
  end
end
