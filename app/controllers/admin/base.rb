class Admin::Base < ApplicationController
  before_action :authorize
  before_action :check_account
  before_action :check_timeout


  private def authorize
    unless current_administrator
      flash.alert = "管理者としてログインしてください。"
      redirect_to :admin_login
    end
  end

  private def check_account
    if current_administrator && current_administrator.suspended?
      flash.alert = "アカウントが停止されています。"
      redirect_to :admin_root
    end
  end

  TIMEOUT = 60.minutes
  private def check_timeout
    if current_administrator
      if session[:last_access_time] < TIMEOUT.ago
        session.delete(:last_access_time)
        flash.alert = "セッションがタイムアウトしました。"
        redirect_to :admin_login
      else
        session[:last_access_time] = Time.current
      end
    end
  end
  
  
  


  private def current_administrator
    if session[:administrator_id]
      @current_administrator ||=
        Administrator.find(session[:administrator_id])
    end
  end
  helper_method :current_administrator
end