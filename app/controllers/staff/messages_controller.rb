class Staff::MessagesController < Staff::Base
  def index
    @messages = Message.not_deleted.sorted.tagged_as(params[:tag_id]).reduce_sql.page(params[:page])
  end

  def inbound
    @messages = CustomerMessage.not_deleted.sorted.tagged_as(params[:tag_id]).reduce_sql.page(params[:page])
    render action: 'index'
  end

  def outbound
    @messages = StaffMessage.not_deleted.sorted.tagged_as(params[:tag_id]).reduce_sql.page(params[:page])
    render template: 'staff/messages/index'
  end

  def deleted
    @messages = Message.deleted.sorted.reduce_sql.tagged_as(params[:tag_id]).page(params[:page])
    render action: 'index'
  end

  def destroy
    message = CustomerMessage.find(params[:id])
    message.update_column(:deleted, true)
    flash.notice = '問い合わせを削除しました。'
    redirect_back(fallback_location: :staff_root)
  end

  def show
    @message = Message.find(params[:id])
  end
end
