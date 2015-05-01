class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  before_action :authenticate_user!
  after_action :verify_authorized, :except => :index
  after_action :verify_policy_scoped, :only => :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    flash[:error] = "Not authorized"
    redirect_to(request.referrer || root_path)
  end

end
