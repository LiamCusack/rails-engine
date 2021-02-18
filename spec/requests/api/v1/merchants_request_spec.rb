require 'rails_helper'
require 'faker'

describe "Merchant API" do
  describe "Merchant Index" do
    it "sends a list of merchants" do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(merchants[:data].count).to eq(3)

      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id].to_i).to be_an(Integer)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_an(String)
      end
    end

    it "defaults to 20 merchants returned per page" do
      create_list(:merchant, 30)

      get '/api/v1/merchants'

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(merchants[:data].count).to eq(20)
      expect(merchants[:data].count).to_not eq(30)
    end

    it "allows you to choose the the number of results per page and the page number that are displayed" do
      create_list(:merchant, 30)

      get '/api/v1/merchants?per_page=10&page=2'

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(merchants[:data].count).to eq(10)
      expect(merchants[:data].last[:id].to_i - merchants[:data].first[:id].to_i).to eq(9)
    end

    it "returns page one if specified page number is less than 1" do
      create_list(:merchant, 30)

      get '/api/v1/merchants?per_page=10&page=2'

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(merchants[:data].count).to eq(10)
      expect(merchants[:data].last[:id].to_i - merchants[:data].first[:id].to_i).to eq(9)
    end
  end

  describe "Merchant Show" do
    it "can get one merchant by its id" do
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id].to_i).to be_an(Integer)

      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_an(String)
    end

    it "returns 404 if a bad/nonexistant merchant id is queried" do
      get "/api/v1/merchants/1000000"

      expect(response.status).to eq(404)
    end

    it "returns 404 if a string id is queried" do
      get "/api/v1/merchants/'1'"

      expect(response.status).to eq(404)
    end
  end
end
