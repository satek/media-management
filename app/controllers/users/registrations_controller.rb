class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!
  skip_after_action :verify_policy_scoped
  skip_after_action :verify_authorized

end
