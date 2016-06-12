class ApplicationController < ActionController::API

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  serialization_scope :view_context


  def authenticate_user!
    puts "AUTH "
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)
    # byebug
    user_username = options.blank? ? nil : options["username"]
    user = user_username && User.find_by(username: user_username)
    if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
      @current_user = user
    else
      render json: {}, status: 401
    end
  end



  private

  def user_not_authorized
    render json: {}, status: 403
  end

end
