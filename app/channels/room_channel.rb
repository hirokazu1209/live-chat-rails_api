class RoomChannel < ApplicationCable::Channel
  def subscribed
    # コネクションが確立すると、subscribedメソッドが呼び出される
    # stream_from "some_channel"
    stream_from 'room_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # メッセージを打ち込み、そのメッセージデータを受信する度に呼び出されるメソッド
  # Vue.jsからemailとmessageを含んだデータが送られてくる
  def receive(data)
    # emailからfind_byメソッドでユーザーを特定する
    user = User.find_by(email: data['email'])

    if message = Message.create(content: data['message'], user_id: user.id)
      # room_channelチャンネルに接続しているWebブラウザ全てにデータを送信するメソッド
      ActionCable.server.broadcast 'room_channel', {message: data['message'], name: user.name, created_at: message.created_at}
    end
  end
end
