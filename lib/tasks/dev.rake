namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")
      #file =File.open(File.join(Rails.root, FFaker::Avatar.image))
      user = User.new(
        name: name,
        email: "#{name}@example.com",
        password: "12345678",
        intro: FFaker::Lorem::sentence(33),
        avatar: file
      )
     # puts FFaker::Avatar.image
      user.save!
      puts user.name
    end
  end


end
