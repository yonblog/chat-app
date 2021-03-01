module SignInSupport
  def sign_in(user)
      # ↑「sign_in」というメソッドを定義。
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on('Log in')
    expect(current_path).to eq(root_path)
      # ↑ここに記述されている内容は、「ユーザーログイン機能テスト」「メッセージ送信機能テスト」「チャット削除機能テスト」で使用するため、このファイルでまとめている。
  end
end