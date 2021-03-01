require 'rails_helper'

RSpec.describe 'メッセージ投稿機能', type: :system do
  before do
    # 中間テーブルを作成して、usersテーブルとroomsテーブルのレコードを作成する
    @room_user = FactoryBot.create(:room_user)
  end

  context '投稿に失敗したとき' do
    it '送る値が空の為、メッセージの送信に失敗すること' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # DBに保存されていないことを確認する
      # （チャットルームに入りメッセージを送信する際に、何も入力せずに送信したため、送信が失敗している挙動を確認している。）
      expect {
        find('input[name="commit"]').click
      }.not_to change { Message.count }
        # ↑「find('input[name="commit"]').click」は、メッセージを送信するためにfindメソッドを使用して、送信ボタンの「input[name="commit"]」要素を取得して、クリックするという意味。
        # 「not_to change { Message.count }」は、何も入力を行っていないので、データベースのmessageモデルのカウントが増えていないことを確認しているという意味。


      # 元のページに戻ってくることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))
      # ※送信に失敗した場合は、元のページ、すなわちメッセージ一覧画面に遷移していることを確認している。
    end
  end

  context '投稿に成功したとき' do
    it 'テキストの投稿に成功すると、投稿一覧に遷移して、投稿した内容が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 値をテキストフォームに入力する
      post = 'テスト'
      fill_in 'message_content', with: post

      # 送信した値がDBに保存されていることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)
      # ↑「送信ボタンを押した時に、Message.countが1つ増える。」

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))
      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)
    end

    it '画像の投稿に成功すると、投稿一覧に遷移して、投稿した画像が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')
                    # ↑この記述でテスト用の画像パスを生成している。
                    # ※「Rails.root」とすると、このRailsアプリケーションのトップ階層のディレクトリまでの絶対パスを取得できる。
                    # パスの情報に対してjoinメソッドを利用することで、引数として渡した文字列でのパス情報を、Rails.rootのパスの情報につけることができる。
                    # ※たとえば、Rails.rootメソッドの戻り値が"/Users/taro/projects/chat_app"だった場合、Rails.root.join('public/images/test_image.png')の戻り値は"/Users/taro/projects/chat_app/public/images/test_image.png"ということになる。

      # 画像選択フォームに画像を添付する
      attach_file('message[image]', image_path, make_visible: true)
        # ↑「attach_file」は、画像などのアップロード用のinput要素に、画像投稿のテスト用の画像を添付（アタッチ）できるメソッド。
                                                  # ↑「make_visible: true」を付けることで非表示になっている要素も一時的に hidden でない状態になる。

      # 送信した値がDBに保存されていることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))

      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector('img')
    end

    it 'テキストと画像の投稿に成功すること' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')

      # 画像選択フォームに画像を添付する
      attach_file('message[image]', image_path, make_visible: true)
      # 値をテキストフォームに入力する
      post = 'テスト'
      fill_in 'message_content', with: post

      # 送信した値がDBに保存されていることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change{ Message.count }.by(1)

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)
      
      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector('img')

    end
  end
end