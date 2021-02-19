class Api::V1::Items::RevenueController < ApplicationController
  def index
    if params[:quantity].present? && params[:quantity].to_i > 0
      items = Item.find_top_item_revenue(params)
      render json: ItemRevenueSerializer.new(items)
    elsif params[:quantity].present? == false
      render json: { data: [] }, status: 400
    else params[:quantity] == (nil || "")
      render json: { data: [] }, status: 400
    end
  end
end
