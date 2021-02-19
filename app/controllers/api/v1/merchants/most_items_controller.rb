class Api::V1::Merchants::MostItemsController < ApplicationController
def index
  if params[:quantity].present? && params[:quantity].to_i > 0
    merchants = Merchant.list_by_most_items_sold(params)
    render json: MerchantMostItemsSerializer.new(merchants)
  elsif params[:quantity].present? == false
    render json: { error: {} }, status: 400
#if i switch out the render for the code below, it makes the requirements in the expectations pass but the tests in postman fail
    # params[:quantity] = 5
    # merchants = Merchant.list_by_most_items_sold(params)
    # render json: MerchantMostItemsSerializer.new(merchants)
  else params[:quantity] == (nil || "")
    render json: { error: {} }, status: 400
  end
  end
end
