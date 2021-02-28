class CreateRoomUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :room_users do |t|
      t.references :room, foreign_key: true
      # ↑「references」は、Railsで外部キーのカラムを追加する際に用いる型。「foreign_key: true」という制約を設けることで、他テーブルの情報を参照できる。
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
