class RoomsController < ApplicationController
  def index
    
  end

  def new
    @room = Room.new
  end

  def create
      # ↑user_idsに配列を記述して、createメソッドを実行することで、そのモデルに紐づくテーブルのレコードの他、中間テーブルへもレコードを複数同時に保存されている。
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    room = Room.find(params[:id])
                    # ↑paramsには、roomテーブルのレコード(id,name,created_at,updated_at)が入っており、「params[:id]」とすることでroom_idが取得されている。
                    # ※findはレコード１行を取得するものなので、まずparamsからidを選んで、その後findでそのidが所属するレコード１行を取得している。　
    room.destroy
    redirect_to root_path
  end

  private
  def room_params
    params.require(:room).permit(:name, user_ids: [])
                                                # ↑配列に対して保存を許可したい場合は、キーに対し[]を値として記述する。
                                                # ※今回取得されているparamsには｛"room" => ｛"user_ids" => 「"選択したユーザーのid", "現在ログインしているユーザーのid"」｝｝と配列が含まれているから。
  end
end
