class SearchFacade
  def self.find_one_merchant_by_name(params, any_class)
    if params[:name].present?
      Search.find_one_by_name(params, any_class)
    elsif params[:name].nil?
      render json: { data: {} }
    end
  end
end
