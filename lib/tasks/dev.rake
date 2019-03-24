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

  task fake_shashin: :environment do
    Shashin.destroy_all
    User.all.each do |user|
      rand(20).times do

      shashin = Shashin.new(
          title: user.name,
          description: user.intro,
          user_id: user.id,
          file_location: user.avatar
      )
     # puts FFaker::Avatar.image
      shashin.save!

      end
    end
    puts "create fake shashins"
  end

  task fake_likes: :environment do
    Favorite.destroy_all

    User.all.each do |user|
      rand(2..22).times do 
        user.favorites.create!(shashin_id: Shashin.all.sample.id)
        #user.favorites.create!(user_id: User.all.sample.id, like_id: User.all.sample.id)
      end
    end
    puts "have created 400 fake likes"
    
end

task fake_send_mails: :environment do
    #@users = User.order(favorites_count: :desc).limit(100)

    now = Time.current 
    @cities = Favorite.where("updated_at BETWEEN ? AND ?", now.prev_month.beginning_of_month, now.prev_month.end_of_month) .group(:user_id).order("count(*) desc limit 100" ).count
    @top100_ids = deep_hash_keys(@cities)
    @users = User.where(:id => @top100_ids)

    @users.all.each do |user|
     # UserMailer.send_promote_code(user).deliver_now!
      puts "send " + user.email
    end
    puts "end "
end




end
