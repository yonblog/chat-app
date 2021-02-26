class Room < ApplicationRecord
  has_many :room_users, dependent: :destroy
                         # ↑dependentオプションに:destroyを指定したときは、親モデルが削除されたとき、それに紐付ている子モデルも一緒に削除される。
  has_many :users, through: :room_users
  has_many :messages, dependent: :destroy
                         # ↑dependentオプションに:destroyを指定したときは、親モデルが削除されたとき、それに紐付ている子モデルも一緒に削除される。

  validates :name, presence: true
end
