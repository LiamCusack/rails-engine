class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: %i[ show destroy ]

  def index
    items = Item.paginate(params)
    render json: ItemSerializer.new(items)
  end

  def show
    render json: ItemSerializer.new(@item)
  end

  def create
    item = Item.create(item_params)
    render json: ItemSerializer.new(item), status:201
  end

  def update
      item = Item.find(params[:id])
      item.update!(item_params)
      render json: ItemSerializer.new(item)
  end

  def destroy
    render json: Item.delete(params[:id])
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end
