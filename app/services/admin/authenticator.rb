class Admin::Authenticator
  def initialize(admin)
    @admin = admin
  end

  def authenticate(raw_password)
    @admin &&
      @admin.hashed_password.present? &&
      BCrypt::Password.new(@admin.hashed_password) == raw_password
  end
  
end