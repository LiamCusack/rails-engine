require "rails_helper"

describe "merchant search" do
  it "returns the first merchant that fits the search queryr" do
    get '/api/v1/merchants/find?name=iLI'

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
  end
end
