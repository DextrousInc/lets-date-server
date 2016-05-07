class Api::UsersController < Api::BaseController
  def show
    user = User.find(params[:id])
    render(json: Api::UserSerializer.new(user).to_json)
  end
  def list
    users = User.all
    users_json = []
    users.each { |user|
      users_json << Api::UserSerializer.new(user)
      }
    render(json: users_json.to_json)
  end

  def date_list
    if params[:id]
      current_user = User.find_by(id: params[:id])
      users = User.where(gender: current_user.preference, preference: current_user.gender).where.not(id: params[:id])
    end
    users_json = []
    users.each { |user|
      users_json << Api::UserSerializer.new(user)
      }
    render(json: users_json.to_json)
  end
  def login
    user_auth = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    response_hash = {}
    if user_auth
      response_hash[:success] = true
      response_hash[:item] = Api::UserSerializer.new(user_auth)
    else
      response_hash[:success] = false
      response_hash[:msg] = 'Invalid Login'
    end
    render(json: response_hash.to_json)
  end
end
