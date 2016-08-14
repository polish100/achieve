class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @conversations = Conversation.all
  end

  def create
    # sender_idが2でrecipient_idが3の時
    # SELECT "conversations".* FROM "conversations" WHERE
    # ((conversations.sender_id = 2 AND conversations.recipient_id =3) OR
    # (conversations.sender_id = 3 AND  conversations.recipient_id =2))
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
