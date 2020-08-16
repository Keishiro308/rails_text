class Admin::SessionsController < Admin::Base
  def new
    if current_administrator
      flash.alert = "ログインしています。"
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
    end
  end

  def create
    @form = Admin::LoginForm.new(login_form_params)
    if @form.email.present?
      admin = Administrator.find_by("LOWER(email) = ?", @form.email.downcase)
    end
    if Admin::Authenticator.new(admin).authenticate(@form.password)
      if admin.suspended?
        flash.now.alert = "アカウントが停止されています。"
        render action: "new"
      else
        session[:administrator_id] = admin.id
        flash.notice = "ログインしました。"
        redirect_to :admin_root
      end
    else
      flash.now.alert = "メールアドレスまたはパスワードが間違っています。"
      render action: "new"
    end
  end

  def destroy
    session.delete(:administrator_id)
    flash.notice = "ログアウトしました。"
    redirect_to :admin_root
  end

  private def login_form_params
    params.require(:admin_login_form).permit(:email, :password)
  end
  
  
  
end
