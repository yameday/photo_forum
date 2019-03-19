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

  task fake_likes: :environment do
    Favorite.destroy_all

    User.all.each do |user|
      20.times do 
        user.favorites.create(user_id: User.all.sample.id)
      end
    end
    puts "have created 400 fake follow"
    
end

task fake_follow: :environment do
    Favorite.destroy_all

    User.all.each do |user|
      favorites = User.all.sample(rand(2..22))
      if favorites.include?(user)
        favorites.delete(user)
      end
      for like in favorites
        user.favorites.create!(like: like)
      end
    end
    puts "create fake_follow"
end


end
