class Api::UsersController < Api::BaseController
  def show
    user = Users.find(params[:id])
    render(json: Api::UserSerializer.new(user).to_json)
  end
  def list
    users = Users.all
    users_json = []
    users.each { |user|
      users_json << Api::UserSerializer.new(user)
      }
    render(json: users_json.to_json)
  end
end
