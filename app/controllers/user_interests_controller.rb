class UserInterestsController < ApplicationController

    APP_CONFIG = YAML.load_file(Rails.root.join('config/config.yml'))[Rails.env]
    def show
      @user_id = params[:id]

      current_user_sub_categories = []
      if params[:id].to_f != session[:current_user_id].to_f
        current_user_interests = UserInterest.where(user_id: session[:current_user_id])
        current_user_interests.each { |item|
          unless current_user_sub_categories.include?(item.sub_category)
            current_user_sub_categories << item.sub_category
          end
        }
      end
      interests = UserInterest.where(user_id: params[:id])
      interest_categories = InterestCategory.all
      @interest_map = {}
      if !interest_categories.blank?
       interest_categories.map { |ic|
           @interest_map[ic[:id]] = {
             :name => ic[:category],
             :value => []
           }
         }
      end
      if !interests.blank?
       interests.map { |item|
         @interest_map[item[:interest_category_id]][:value] << {
           :name => item[:interest_name],
           :is_common => current_user_sub_categories.include?(item[:sub_category])
         }
        }
      end
    end
    def impress
      @chosen_user = User.find_by(id: params[:id])
      @interest_category = InterestCategory.find_by(id: params[:category])
      @interested_sub_categories = UserInterest.where(interest_category_id: params[:category], user_id: params[:id])
      @logged_user = User.find_by(id: session[:current_user_id])

      start_location = [@logged_user.home_latitude, @logged_user.home_longitude]
      end_location = [@chosen_user.home_latitude, @chosen_user.home_longitude]
      # compute the centre between both of them
      centre_location = Geocoder::Calculations.geographic_center([start_location, end_location])

      # get the distance and check it with the minimum required radius from config
      distance_between_them = Geocoder::Calculations.distance_between(start_location, end_location, {:units => :km})
      if distance_between_them < APP_CONFIG['MIN_RADIUS']
        distance_between_them = APP_CONFIG['MIN_RADIUS']
      end
      # define zoom based on distance
      zoom = APP_CONFIG['MIN_ZOOM'].to_i

      # greater is the distance lesser it the zoom
      zoom = zoom + (APP_CONFIG['MIN_RADIUS']/distance_between_them).to_i
      if zoom > APP_CONFIG['MAX_ZOOM'].to_i
        zoom = APP_CONFIG['MAX_ZOOM'].to_i
      end
      if distance_between_them < APP_CONFIG['MIN_RADIUS']
        distance_between_them = APP_CONFIG['MIN_RADIUS']
      end
      @api_key = APP_CONFIG['GOOGLE_MAPS_API_KEY'] # fetch from config file

      # set it to a model to render in the script tag
      @centre = {
        :latitude => centre_location[0], #-33.8665,
        :longitude => centre_location[1], #151.1956,
        :radius => distance_between_them*1000 , # => meteres
        :zoom => zoom # closer they both are greater is the zoom level
      }
    end
    def new
     @user_interest = UserInterest.new
     @user_id_value = params[:id]
     @category_value = params[:category]
    end

    def create
      @user_interest = UserInterest.new(user_interest_params)
      if @user_interest.save
        redirect_to :action => 'show', :id => @user_interest.user_id
      else
        render :action => 'new'
      end
    end

    def user_interest_params
     params.require(:user_interests).permit(:interest_name, :interest_category_id, :sub_category, :user_id)
    end
end
