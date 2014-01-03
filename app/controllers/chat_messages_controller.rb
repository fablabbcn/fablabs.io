class ChatMessagesController < ApplicationController
  before_filter :require_login

  def index
  end

  def create
    @chat_message = ChatMessage.new(params[:chat_message])
    PrivatePub.publish_to("/chat_messages/new", chat_message: @chat_message, author: { name: current_user.full_name, id: current_user.id })
  end

end
