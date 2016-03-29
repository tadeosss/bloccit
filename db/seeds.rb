require 'random_data'

# Create Topics
15.times do
 Topic.create!(
   name:         RandomData.random_sentence,
   description:  RandomData.random_paragraph
 )
end
topics = Topic.all
puts "#{Topic.count} topics created"

# Create Posts
50.times do
  Post.create!(
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
    )
end
posts = Post.all
puts "#{Post.count} posts created"

# Create Comments
100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
    )
end
puts "#{Comment.count} comments created"

# Create Sponsored Posts
50.times do
  SponsoredPost.create!(
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
    )
end
posts = SponsoredPost.all
puts "#{SponsoredPost.count} sponsored posts created"

puts "Seed finished"