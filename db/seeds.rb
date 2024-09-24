# db/seeds.rb

# Supprimer les données existantes pour éviter les conflits
Like.destroy_all
Comment.destroy_all
PrivateMessage.destroy_all
Gossip.destroy_all
Tag.destroy_all
User.destroy_all
City.destroy_all

# Créer des villes
10.times do
  City.create!(
    name: Faker::Address.city,
    zip_code: Faker::Address.zip_code
  )
end
puts "#{City.count} villes créées."

# Créer des utilisateurs
10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.sentence,
    email: Faker::Internet.email,
    age: rand(18..60),
    city: City.order("RANDOM()").first # Lier l'utilisateur à une ville existante
  )
end
puts "#{User.count} utilisateurs créés."

# Créer des tags
10.times do
  Tag.create!(
    title: Faker::Lorem.word # Créer des tags avec un titre aléatoire
  )
end
puts "#{Tag.count} tags créés."

# Créer des gossips
20.times do
  gossip = Gossip.create!(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraph,
    user: User.order("RANDOM()").first # Lier le gossip à un utilisateur existant
  )
  puts "Gossip créé : #{gossip.title}" if gossip.persisted?
end
puts "#{Gossip.count} gossips créés."

# Créer des commentaires
20.times do
  gossip = Gossip.order("RANDOM()").first
  user = User.order("RANDOM()").first

  if gossip && user
    Comment.create!(
      content: Faker::Lorem.sentence,
      user: user,
      gossip: gossip
    )
  end
end
puts "#{Comment.count} commentaires créés."

# Créer des messages privés
User.all.each do |sender|
  recipient = User.where.not(id: sender.id).order("RANDOM()").first
  if recipient
    PrivateMessage.create!(
      content: Faker::Lorem.sentence,
      sender_id: sender.id,
      recipient_id: recipient.id
    )
  end
end
puts "#{PrivateMessage.count} messages privés créés."

# Créer des likes pour des gossips et des commentaires
20.times do
  user = User.order("RANDOM()").first # Lier le like à un utilisateur
  if [true, false].sample # Choisir aléatoirement entre un gossip et un commentaire
    likeable = Gossip.order("RANDOM()").first # Choisir un gossip aléatoire
  else
    likeable = Comment.order("RANDOM()").first # Choisir un commentaire aléatoire
  end

  Like.create!(
    user: user,
    likeable: likeable # Associer le like au gossip ou au commentaire
  ) if likeable
end
puts "#{Like.count} likes créés."
