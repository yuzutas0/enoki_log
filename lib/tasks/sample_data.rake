namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    User.create!(email: "example@hogehoge.jp",
                 password: "foobar",
                 password_confirmation: "foobar")
    80.times do |n|
      email = "example-#{n+1}@hogehoge.jp"
      password  = "password"
      User.create!(email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    # URL制約（12桁・16進数・Unique）を守りながらデータを作るための処理
    32.times do |n|
      next if n < 10
      title = Faker::Lorem.sentence(3)
      i = 11
      users.each do |user|
        user.subjects.create!(title: title,
                              description: "example-#{n}",
                              url: "12345abc#{i}#{n}",
                              start_day: Date.new(2014, 1, 1),
                              end_day: Date.new(2014, 2, 1))
        i += 1
      end
    end

  end
end
