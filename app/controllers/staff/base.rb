class Staff::Base < ApplicationController
  private def current_staff_member
    if session[:staff_member_id]
      @staff_member ||=
        StaffMember.find(session[:staff_member_id])
    end
  end
  
  helper_method :current_staff_member
end