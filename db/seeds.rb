class Seed

  def self.start
    p "starting seed generation"
    seed = Seed.new
    seed.reset_data
    seed.generate_users
  end

  def reset_data
    Link.destroy_all
    User.destroy_all
    p "deleted links and users"
  end

  def generate_users
    p "making users"
    3.times do |i|
      user = User.create!(
                email: "user#{i}@test.com",
                password: "password",
              )
      make_links(user)
      p "created #{user.email}"
    end

  end

  def make_links(user)
    p "making links"
    3.times do |i|
      link = Link.create!(
              title: Faker::Hipster.words(2).join(' '),
              url: Faker::Internet.url,
              user_id: user.id
              )
      p "made #{link.title} for #{user.email}"
    end
  end
end

Seed.start
