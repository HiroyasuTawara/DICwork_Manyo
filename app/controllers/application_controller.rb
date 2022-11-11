class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :login_required

  private

  def login_required
    unless current_user
      redirect_to new_session_path, notice: "ログインを行なってください。"
    end
  end
  
end
