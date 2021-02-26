class UsersController < ApplicationController
  def edit
    
  end
  def update
    if current_user.update(user_params)
      # ※current_userメソッドは、サインインしているユーザー情報を取得するメソッド。
      # ↑「もし現在のユーザー情報がupdateされたら、root_path(room.index.html.erb)へリダイレクトする」
      redirect_to root_path
      # ※「redirect_to」はルーティングを経由して指定したパスに遷移するため、情報が更新される。
    else
      render :edit
      # ※「render」はルーティングを経由せず、そのまま指定されたページが表示されるだけなので、情報が更新されない。
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
    # ※パラメーター.require(:モデル名).permit(:キー名, :キー名)
    # ↑「送られてきたnameとemailの値を、ストロングパラメーターを使って安全に取得する」という記述。
  end
end
