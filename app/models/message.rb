class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one_attached :image
    # ↑各レコードとファイルを1対1の関係で紐づけるメソッド。「has_one_attached :任意のファイル名」
    # ※「モデル.ファイル名」で、添付されたファイルにアクセスできるようになり、このファイル名は、そのモデルが紐づいたフォームから送られるパラメーターのキーにもなる。

  validates :content, presence: true, unless: :was_attached?
                                      # ↑validatesのunlessオプションにメソッド名を指定することで、「メソッドの返り値がfalseならばバリデーションによる検証を行う」という処理になる。
  def was_attached?
    self.image.attached?
                # ↑画像があればtrue、なければfalseを返すという意味。
    # ↑クラスメソッドとして使いたい場合はselfを付ける、インスタンスメソッドとして使いたい場合はselfを付けない。
  end
end
