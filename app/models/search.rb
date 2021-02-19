class Search < ApplicationRecord
  def self.find_one_by_name(params, any_class)
    any_class.where('name iLIKE ?', "%#{params[:name]}%")
             .first
  end

  def self.find_all_by_name(params, any_class)
    any_class.where('name iLIKE ?', "%#{params[:name]}%")
             .order(:name)
  end
end
