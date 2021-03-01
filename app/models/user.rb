class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  # ↑「nameが空の値の場合は、データベースに保存できない。」という意味。
  # ※nameだけバリデーションを記述している理由は、nameはもともとdeviseに用意されていないカラムだったため。e-mailとpasswordは、最初から「presence: true」とdeviseに設定されている。

  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :messages
end