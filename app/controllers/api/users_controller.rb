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
end
