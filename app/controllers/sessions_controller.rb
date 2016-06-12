class SessionsController < ActionController::API

  # GET /sessions/1
  def create
    user = User.find_by(username: create_params[:username])
        .try(:authenticate, create_params[:password])
    # User.find_by(username: "morgan").try?(:authenticate, "nope")
    if user
      #render json: user
      render(
        json: SessionSerializer.new(user, root: false).to_json,
        status: 201
      )
    else
      render json: {}, status: 401
    end
  end

  private

    def create_params
      params.permit(:username, :password)
    end

end
