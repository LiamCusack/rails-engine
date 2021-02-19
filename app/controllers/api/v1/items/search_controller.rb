class Api::V1::Items::SearchController < ApplicationController
  def index
    items = Search.find_all_by_name(params, Item)
    if params[:name].present?
      render json: ItemSerializer.new(items)
    else
      render json: { data: [] }
    end
  end
end
