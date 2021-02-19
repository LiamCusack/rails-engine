class Search < ApplicationRecord
  def self.find_one_by_name(params, any_class)
    any_class.where('name LIKE ?', "%#{(params[:name].downcase)}%")
             .first
  end
end
