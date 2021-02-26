class ApplicationController < ActionController::Base
  before_action :authenticate_user!
                  # ↑ログイン状態によって表示するページを切り替えるdeviseのメソッド。処理が呼ばれた段階で、ユーザーがログインしていなければ、そのユーザーをログイン画面に遷移させる。
                  # ※before_actionで呼び出すことで、他のアクションが実行される前にログインしてなければログイン画面に遷移させられる。
  before_action :configure_permitted_parameters, if: :devise_controller?
                                                # ↑「もしdeviseのコントローラーが呼び出されたら、configure_permitted_parametersを起動する」
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # ↑「ログイン」「新規登録」などのリクエストからパラメーターを取得できるようになるメソッド。
    # ※新しく追加した「name」キーの内容をストロングパラメーターに含めるために、permitメソッドで許可している。
  end
end
