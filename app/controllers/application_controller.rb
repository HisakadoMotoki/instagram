class ApplicationController < ActionController::Base
helper_method :logged_in?

  def logged_in?
    !!current_user
  end
end
