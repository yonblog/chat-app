require 'rails_helper'

RSpec.describe 'ユーザーログイン機能', type: :system do
  it 'ログインしていない状態でトップページにアクセスした場合、サインインページに移動する' do
    # トップページに遷移する
    visit root_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path). to eq(new_user_session_path)
    # ↑ログインしていない状態のユーザーがトップページにアクセスした場合は、サインインページに遷移される。
    # 「current_path」は、今アクセスしているページの情報が含まれているので、expect(X).to eq(Y)メソッドを用いて、「X」を「current_path」、「Y」を「new_user_session_path」としている。
    # つまり、「current_path（現在のページ）」は「new_user_session_path（サインインページ）」となることを確認している。
  end
  
  it 'ログインに成功し、トップページに遷移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    # ↑まずはcreateメソッドを使って、データベースにテスト用のユーザーを保存している。
    # サインインページへ移動する
    visit new_user_session_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path). to eq(new_user_session_path)
    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    # ログインボタンをクリックする
    click_on('Log in')
    # ↑「click_on」は、'Log in'をクリックする動作をチェックしている。
    # トップページに遷移していることを確認する
    expect(current_path). to eq(root_path)
  end
  
  it 'ログインに失敗し、再びサインインページに戻ってくる' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    # トップページに遷移する
    visit root_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq(new_user_session_path)
    # 誤ったユーザー情報を入力する
    fill_in 'user_email', with: 'test'
    fill_in 'user_password', with: 'test'
    # ログインボタンをクリックする
    click_on('Log in')
    # サインインページに戻ってきていることを確認する
    expect(current_path).to eq(new_user_session_path)
  end
end
