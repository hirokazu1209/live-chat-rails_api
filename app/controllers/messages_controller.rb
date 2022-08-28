class MessagesController < ApplicationController
  before_action :authenticate_user!, only: ["index"]

  def index
    # :user_メッセージに紐づくユーザーの一覧を取得
    # [likes:]_メッセージに紐づくいいねの一覧を取得
    # [likes: :user]_likes:に紐づくユーザーの一覧を取得
    messages = Message.includes(:user, [likes: :user])
    # オブジェクトを作成し、格納していく
    messages_array = messages.map do |message|
      {
        id: message.id,
        user_id: message.user.id,
        name: message.user.name,
        content: message.content,
        email: message.user.email,
        created_at: message.created_at,
        likes: message.likes.map{|like| {id: like.id, email: like.user.email}}
      }
    end

    render json: messages_array, status: ok
  end
end
