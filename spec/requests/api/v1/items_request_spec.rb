require 'rails_helper'

describe "Item API" do
  describe "Item Index" do
    it "sends a list of items" do
      merchant = create(:merchant)
      create_list(:item, 3)

      get '/api/v1/items'

      items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(items[:data].count).to eq(3)

      items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id].to_i).to be_an(Integer)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_an(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_an(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_an(Float)
      end
    end
  end

  describe "Item Show" do
    it "can get one item by its id" do
      merchant = create(:merchant)
      id = create(:item).id

      get "/api/v1/items/#{id}"

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(item[:data][:id].to_i).to eq(id)
      expect(item[:data]).to have_key(:id)
      expect(item[:data]).to have_key(:type)
      expect(item[:data]).to have_key(:attributes)
      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes]).to have_key(:merchant_id)
    end
    it "returns 404 if a bad/nonexistant item id is queried" do
      get "/api/v1/items/1000000"

      expect(response.status).to eq(404)
    end

    it "returns 404 if a string id is queried" do
      get "/api/v1/items/'1'"

      expect(response.status).to eq(404)
    end
    
  end
  describe 'Items Create' do
    it 'can create a new item' do
      merchant = create(:merchant)

      item_params = ({
        name: 'Mr. Item',
        description: "Item description",
        unit_price: 100.1,
        merchant_id: merchant.id
        })

        headers = {"CONTENT_TYPE" => "application/json"}

        post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

        created_item = Item.last

        expect(response).to be_successful
        expect(created_item.name).to eq(item_params[:name])
        expect(created_item.description).to eq(item_params[:description])
        expect(created_item.unit_price).to eq(item_params[:unit_price])
    end
  end
  describe "Items Update" do
    it "can update an existing Item" do
      merchant = create(:merchant)
      id = create(:item).id

      previous_name = Item.last.name
      item_params = { name: "Dumb item"}
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
      item = Item.find_by(id: id)

      expect(response).to be_successful
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq("Dumb item")
    end
  end

  describe "destroy" do
    it "can destroy an Item" do
      merchant = create(:merchant)
      item = create(:item)

      expect(Item.count).to eq(1)

      delete "/api/v1/items/#{item.id}"

      expect(response).to be_successful
      expect(Item.count).to eq(0)
      expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
    it "can destroy an Item" do
      merchant = create(:merchant)
      item = create(:item)

      expect{delete "/api/v1/items/#{item.id}"}.to change(Item, :count).by(-1)

      expect(response).to be_successful
      expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
