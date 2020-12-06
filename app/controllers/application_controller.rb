class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # skip_before_action :authenticate_user!, if: :high_scores_controller?
  before_action :authenticate_user!

  # before_action :configure_permitted_parameters, if: :devise_controller?
end
