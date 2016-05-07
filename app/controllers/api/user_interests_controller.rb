class Api::UserInterestsController < Api::BaseController
  APP_CONFIG = YAML.load_file(Rails.root.join('config/config.yml'))[Rails.env]
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
  def impress
    chosen_user = User.find_by(id: params[:id])
    interest_category = InterestCategory.find_by(id: params[:category])
    interested_sub_categories = UserInterest.where(interest_category_id: params[:category], user_id: params[:id])
    logged_user = User.find_by(id: params[:userId])

    start_location = [logged_user.home_latitude, logged_user.home_longitude]
    end_location = [chosen_user.home_latitude, chosen_user.home_longitude]
    # compute the centre between both of them
    centre_location = Geocoder::Calculations.geographic_center([start_location, end_location])

    # define zoom based on distance
    zoom = 8 #Min Zoom
    # get the distance and check it with the minimum required radius from config
    distance_between_them = Geocoder::Calculations.distance_between(start_location, end_location, {:units => :km})

    # greater is the distance lesser it the zoom
    zoom = zoom + (APP_CONFIG['MIN_RADIUS']/distance_between_them).to_i
    if zoom > APP_CONFIG['MAX_ZOOM'].to_i
      zoom = APP_CONFIG['MAX_ZOOM'].to_i
    end
    if distance_between_them < APP_CONFIG['MIN_RADIUS'].to_f
      distance_between_them = APP_CONFIG['MIN_RADIUS'].to_i
    end

    response = {}
    response[:success] = true
    response[:partner] = Api::UserSerializer.new(chosen_user)
    response[:logged_user] = Api::UserSerializer.new(logged_user)
    interested_meta = []
    interested_sub_categories.each { |sc|
      unless interested_meta.include?(sc.sub_category)
        interested_meta << sc.sub_category
      end
    }
    # set it to a model to render in the script tag
    response[:centre] = {
      :latitude => centre_location[0], #-33.8665,
      :longitude => centre_location[1], #151.1956,
      :radius => distance_between_them * 1000 , # => meteres
      :zoom => zoom, # closer they both are greater is the zoom level
      :interested_places => interest_category.place,
      :places_meta => interested_meta
    }
    render(json: response.to_json)
  end
end
