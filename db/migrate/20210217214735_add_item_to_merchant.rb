class AddItemToMerchant < ActiveRecord::Migration[5.2]
  def change
    add_reference :merchants, :item, foreign_key: true
  end
end
