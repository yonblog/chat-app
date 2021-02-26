class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one_attached :image
    # ↑各レコードとファイルを1対1の関係で紐づけるメソッド。「has_one_attached :任意のファイル名」
    # ※「モデル.ファイル名」で、添付されたファイルにアクセスできるようになり、このファイル名は、そのモデルが紐づいたフォームから送られるパラメーターのキーにもなる。

  validates :content, presence: true
end
