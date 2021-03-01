FactoryBot.define do
  factory :room_user do
    association :user
    association :room
  end
end
# ↑ここは「associationメソッド」の記述。FactoryBotによって生成されるモデルを関連づけるメソッド。
# ※これで、中間テーブルのテスト用モデルにアソシエーションが定義できる。