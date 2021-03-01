FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    association :user
    association :room

    after(:build) do |message|
    # ↑「afterメソッド」は、任意の処理の後に指定の処理を実行することができる。例えば、after(:build) とすることで、インスタンスがbuildされた後に指定の処理を実行できる。
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
                          # ↑「io: File.open」は、public/images/test_image.pngを、「test_image.png」というファイル名で保存するという意味。
    end
  end
end