class VisitorsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_policy_scoped

end
