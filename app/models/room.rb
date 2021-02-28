class Room < ApplicationRecord
  has_many :room_users, dependent: :destroy
                         # ↑dependentオプションに:destroyを指定したときは、親モデルが削除されたとき、それに紐付ている子モデルも一緒に削除される。
  has_many :users, through: :room_users
                    # ↑throughオプションは、モデルに多対多の関連を定義するときに利用する。throughという名前のとおり、「〜を経由する」という意味。
  has_many :messages, dependent: :destroy
                         # ↑dependentオプションに:destroyを指定したときは、親モデルが削除されたとき、それに紐付ている子モデルも一緒に削除される。

  validates :name, presence: true
end
