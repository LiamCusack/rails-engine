class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.paginate(params)
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(merchant)
  end

  def find
      merchant = Merchant.find_one_by_name(params)
      if merchant.nil?
        render json: {"data" => {}}, status:200
      else
      render json: MerchantSerializer.new(merchant)
      end
  end
end
