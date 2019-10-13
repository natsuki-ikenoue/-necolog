class MessagesController < ApplicationController
  before_action :correct_user, only: [:destroy]
  
  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    if @message.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @message.destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private
  def message_params
    params.require(:message).permit(:content, :post_id)
  end
  
  def correct_user
    @message = current_user.messages.find_by(id: params[:id])
    unless @message
      redirect_to root_url
    end
  end
end