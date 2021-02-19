class MerchantMostItemsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :count
end
