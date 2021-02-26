class MessagesController < ApplicationController
  def index
    # ↑_side_bar.html.erbのチャットルーム名がクリックされたら起動される。
    @message = Message.new
    # ↑「Messageモデルのからのインスタンス（Message.new）」
    @room = Room.find(params[:room_id])
    # ↑「指定のチャットルーム(今回はroomテーブルのid)のレコード情報」
    @messages = @room.messages.includes(:user)
    # ↑モデル名.includes(:アソシエーションで定義した関連名) 
    # ↑ルーム名.ルームに関連するメッセージ全部.includes(:投稿したしたユーザー) → Nobuのチャットルーム.その中のメッセージ.の中でnobuが発信したメッセージ
    # ※「includes」を使えば①roomテーブルの情報を取得 ②それに関連するmessageテーブルの情報を取得 と2回のアクセスで済むためN+1問題が解決される。
  end
  
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    # ↑チャットルームに紐付いたメッセージのインスタンスを生成している。※ルーティングのネストをしているからできる。
    if @message.save
      # ↑生成したインスタンスを@messageに代入し、saveメソッドでメッセージの内容をmessagesテーブルに保存している。
      redirect_to room_messages_path(@room)
      # ↑「もしメッセージが保存できたら、情報を更新してmessages#indexに遷移する。」
    else
      @messages = @room.messages.includes(:user)
      # ↑renderを用いることで、投稿に失敗した@messageの情報を保持しつつindex.html.erbを参照することができるがこの時、indexアクションは経由しないため@messagesが定義されていないとエラーになってしまうから。
      render :index
      # ↑「保存できなかったら、情報を更新せずにmessages#indexに遷移する。」
    end
  end

  private
  # ↑クラス外から呼び出すことのできないメソッドのこと。
  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
            # ↑「require」はパラメーターからどの情報を受け取るかを選択する。
            # ↑「permit」はrequireメソッドのより細部選択が可能になったメソッド。キー単位で選択できる。今回はmessageテーブルのcontentとActive Storageテーブルのimageを選択している。
            # ↑「merge」はハッシュとハッシュを繋げるメソッド。
  end
end
