require "rails_helper"

describe "merchant most_items" do
  it "returns the top 10 merchants with most items sold" do
    # undefined method string=
    merchant1 = create(:merchant, name: "merch1")
    merchant2 = create(:merchant, name: "2merch")
    cust1 = create(:customer)
    cust2 = create(:customer)
    invoice1 = create(:invoice, merchant: merchant1, customer: cust1)
    invoice2 = create(:invoice, merchant: merchant2, customer: cust2)
    item1 = create(:item)
    item2 = create(:item)
    item3 = create(:item)
    ii1 = create(:invoice_item, invoice_id: invoice1.id, item: item1, quantity: 20)
    ii2 = create(:invoice_item, invoice_id: invoice2.id, item: item2, quantity: 2)
    ii3 = create(:invoice_item, invoice_id: invoice2.id, item: item3, quantity: 5)
    t1 = create(:transaction, invoice_id: invoice1.id)
    t2 = create(:transaction, invoice_id: invoice2.id)
    t3 = create(:transaction, invoice_id: invoice2.id)

    get "/api/v1/merchants/most_items?quantity=2"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchant[:data][0][:attributes][:name]).to eq("merch1")
    expect(merchant[:data][0][:attributes][:count]).to eq(20)
    expect(merchant[:data][1][:attributes][:name]).to eq("2merch")
    expect(merchant[:data][1][:attributes][:count]).to eq(14)
  end
end
