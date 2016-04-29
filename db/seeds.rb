require 'random_data'

# Create Users
5.times do
  User.create!(
    name: RandomData.random_name,
    email: RandomData.random_email,
    password: RandomData.random_sentence
  )
end

# Create admin user
unless User.find_by(email: 'admin@example.com')
  User.create!(
    name: 'Admin User',
    email: 'admin@example.com',
    password: 'helloworld',
    role: 'admin'
  )
end

unless User.find_by(email: 'member@example.com')
  User.create!(
    name: 'Member User',
    email: 'member@example.com',
    password: 'helloworld'
  )
end
users = User.all

puts "#{User.count} users created"

#Create Labels
unless Label.all.any?
  label_names = %w(rogue red gold viper wolf bandit yellow blade blue dantooine)
  label_names.each do |label_name|
    Label.create!(
      name: label_name
      )
  end
end
labels = Label.all
puts "#{Label.count} labels created"


# Create Topics
15.times do
 Topic.create!(
   name:         RandomData.random_sentence,
   description:  RandomData.random_paragraph,
   labels: labels.sample(rand(0..5))
 )
end
topics = Topic.all
puts "#{Topic.count} topics created"

# Create Posts
50.times do
  post = Post.create!(
    user: users.sample,
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    labels: labels.sample(rand(0..5))
    )
  post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
  rand(1..5).times { post.votes.create!(value: [-1, 1].sample, user: users.sample) }
end

posts = Post.all
puts "#{Post.count} posts created"
puts "#{Vote.count} votes created"

# Create Comments
100.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: RandomData.random_paragraph
    )
end
puts "#{Comment.count} comments created"

<<<<<<< HEAD
# Create admin user
admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'helloworld',
  role: 'admin'
)

moderator = User.create!(
  name: 'Moderator User',
  email: 'moderator@example.com',
  password: 'helloworld',
  role: 'moderator'
)

member = User.create!(
  name: 'Member User',
  email: 'member@example.com',
  password: 'helloworld'
)
=======
>>>>>>> origin/42_checkpoint

puts "Seed finished"