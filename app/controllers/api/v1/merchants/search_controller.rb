class Api::V1::Merchants::SearchController < ApplicationController
  def show
    merchant = SearchFacade.find_merchant_by_name
    render json: SearchSerializer.new(merchant)
  end
end
