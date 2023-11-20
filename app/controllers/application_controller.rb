# Class that handle the global controller configuration
class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_to_root

  def redirect_to_root
    redirect_to root_path
  end
end
