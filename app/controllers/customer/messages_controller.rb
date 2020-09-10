class Customer::MessagesController < Customer::Base

  def index
    @messages = StaffMessage.where(customer_id: current_customer.id).not_deleted
      .reduce_sql.page(params[:page])
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = CustomerMessage.new
  end

  def confirm
    @message = CustomerMessage.new(customer_message_params)
    @message.customer =  current_customer
    if @message.valid?
      render action: 'confirm'
    else
      flash.now.alert = '入力に誤りがあります。'
      render action: 'new'
    end
  end

  def create
    @message = CustomerMessage.new(customer_message_params)
    if params[:commit]
      @message.customer = current_customer
      if @message.save
        flash.notice = '問い合わせを送信しました。'
        redirect_to :customer_root
      else
        flash.now.alert = '入力に誤りがあります。'
        render action: 'new'
      end
    else
      render aciton: 'new'
    end
  end

  def destroy
    message = StaffMessage.find(params[:id])
    message.update_column(:deleted, true)
    flash.notice = '問い合わせを削除しました。'
    redirect_back(fallback_location: :customer_root)
  end
  

  private def customer_message_params
    params.require(:customer_message).permit(:subject, :body)
  end
  
end
