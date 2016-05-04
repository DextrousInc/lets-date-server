class Api::UserInterestsController < Api::BaseController
  def list
    interests = UserInterest.where(user_id: params[:id])
    interest_categories = InterestCategory.all
    interest_map = {}
    if !interest_categories.blank?
     interest_categories.map { |ic|
         interest_map[ic[:id]] = {
           :name => ic[:category],
           :value => []
         }
       }
    end
    if !interests.blank?
     interests.map { |item|
       interest_map[item[:interest_category_id]][:value] << item[:interest_name]
      }
    end
    render(json: interest_map.to_json)
  end
end
