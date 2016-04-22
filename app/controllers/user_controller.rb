class UserController < ApplicationController
  def home
  end
  def list
    @users = User.all
  end

  def show
   @user = User.find(params[:id])
   interests = UserInterest.where(user_id: params[:id])
   @interest_map = {}
   if !interests.blank?
     interests.map { |item|
       if @interest_map[item[:category]].nil?
         @interest_map[item[:category]] = []
       end
       @interest_map[item[:category]] << item[:names]
      }
      print @interest_map
   end
  end

  def new
   @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
     redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end


  def new_interest
   @user_interest = UserInterest.new
   @user_id_value = params[:id]
  end

  def create_interest
    @user_interest = UserInterest.new(user_interest_params)
    if @user_interest.save
      redirect_to :action => 'show', :id => @user_interest.user_id
    else
      render :action => 'new_interest'
    end
  end

  def edit
   @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(book_param)
       redirect_to :action => 'show', :id => @user
    else
       render :action => 'edit'
    end
  end

  def delete
   User.find(params[:id]).destroy
   redirect_to :action => 'list'
  end

  def user_params
   params.require(:users).permit(:first_name, :last_name, :email, :password, :dob, :gender, :preference, :home_latitude, :home_longitude)
  end

  def user_interest_params
   params.require(:user_interests).permit(:names, :category, :user_id)
  end

end
