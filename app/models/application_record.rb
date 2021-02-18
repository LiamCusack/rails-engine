class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.paginate(params)
    page = [params[:page].to_i, 1].max - 1
    per_page = [params[:per_page].to_i, 20].max
    limit(per_page).offset(per_page * page)
  end
end
