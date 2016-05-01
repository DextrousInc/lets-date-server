class UsersController < ApplicationController

  def list
    @users = User.all
  end

  def new
   @user = User.new
  end

  def view_login
    @user = User.new
  end

  def logout
    session[:current_user] = nil
    session[:display_name] = nil
    session[:current_user_id] = nil
    redirect_to :action => 'home'
  end

  def login
    user_auth = User.new(user_login_params)
    user_auth = User.find_by(email: user_auth.email).try(:authenticate, user_auth.password)
    if user_auth
      session[:current_user] = {
        :id => user_auth.id,
        :first_name => user_auth.first_name,
        :last_name => user_auth.last_name,
        :email => user_auth.email
      }
      session[:display_name] = user_auth.first_name + ' ' + user_auth.last_name
      session[:current_user_id] = user_auth.id
      print session[:current_user]
      redirect_to :action => 'home'
    else
      redirect_to :action => 'view_login'
    end

  end

  def create
    @user = User.new(user_params)
    if @user.save
     redirect_to :action => 'list'
    else
      render :action => 'new'
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
   params.require(:users).permit(:first_name, :last_name, :email, :password, :password_confirmation,  :dob, :gender, :preference, :home_latitude, :home_longitude)
  end

  def user_login_params
   params.require(:users).permit( :email, :password)
  end

end
