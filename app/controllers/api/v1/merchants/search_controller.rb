class Api::V1::Merchants::SearchController < Api::V1::MerchantsController
  def show
    #ask why this worked and like 10million other things didn't
    merchant = Search.find_one_by_name(params, Merchant)
    if merchant.present?
      render json: MerchantSerializer.new(merchant)
    else
      render json: { data: {} }
    end
  end
end
