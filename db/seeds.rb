puts 'Cleaning database...'
FurnituresWishlist.destroy_all
Review.destroy_all
Furniture.destroy_all
Wishlist.destroy_all
Category.destroy_all
User.destroy_all

puts 'Creating users...'
user1 = User.create!(
  first_name:"Guillaume",
  last_name:"Trupin",
  email: "gtrupin@gmail.com",
  password:"azerty",
  password_confirmation:"azerty" ,
  photo: "http://lorempixel.com/400/400/people/1",
  admin: true
  )
user2 = User.create!(
  first_name:"Aubry",
  last_name:"Prieur",
  email: "aubry.prieur@gmail.com",
  password:"qsdfgh",
  password_confirmation: "qsdfgh",
  photo: "http://lorempixel.com/400/400/people/2",
  admin: false
  )
user3 = User.create!(
  first_name:"Bertrand",
  last_name:"Matelart",
  email: "matelart.bertrand@gmail.com",
  password:"wxcvbn",
  password_confirmation: "wxcvbn",
  photo: "http://lorempixel.com/400/400/people/3",
  admin: false
  )
user4 = User.create!(
  first_name:"Augustin",
  last_name:"Poupard",
  email: "ap@gmail.com",
  password:"mlkjhg",
  password_confirmation: "mlkjhg",
  photo: "http://lorempixel.com/400/400/people/4",
  admin: false
  )
user5 = User.create!(
  first_name:"Aurélien",
  last_name:"Bigo",
  email: "ab@gmail.com",
  password:"aqwxsz",
  password_confirmation: "aqwxsz",
  photo: "http://lorempixel.com/400/400/people/5",
  admin: false
  )
puts 'Finished! ---) USER OK'

puts 'Creating whislists...'
wishlist1 = Wishlist.create!(
  title: "Ma chambre",
  description: "Remplacer la commode",
  user: user1,
  )
wishlist2 = Wishlist.create!(
  title: "Le bureau",
  description: "trouver le nouveau bureau de travail",
  user: user1,
  )
wishlist3 = Wishlist.create!(
  title: "La chambre",
  description: "trouver le nouveau bureau de travail",
  user: user1,
  )
wishlist4 = Wishlist.create!(
  title: "Le salon",
  description: "Trouver un table basse",
  user: user2,
  )
wishlist5 = Wishlist.create!(
  title: "La salle de bain",
  description: "Trouver une  nouvelle étagère",
  user: user3,
  )
wishlist6 = Wishlist.create!(
  title: "La piscine",
  description: "Trouver un nouveau meuble tv",
  user: user4,
  )
puts 'Finished! ---) WISHLIST OK'


puts 'Creating furnitures...'
require "open-uri"
require "nokogiri"

base_url = "http://www.ikea.com"
doc = Nokogiri::HTML(open('http://www.ikea.com/ms/fr_FR/produits.html').read)
doc.search('#all_products_01').each do |element|
 category = element.search('.headZeroGray b').text
 link = element.search('.bodyTextGray a').attribute('href').text.strip

 v_doc = Nokogiri::HTML(open(link).read)
 v_doc.search('.product').each do |element|
  img = base_url + element.search('img').attribute('src').text.strip
  v_link = base_url + element.search('a').attribute('href').text.strip
  title = element.search('.productTitle').text.strip
  description = element.search('.productDesp').text.strip
  price = element.search('.price').text.strip
  pattern = /^\s+Largeur:\s(?<width>\d{2})\scm,\s+Profondeur:\s(?<lenght>\d{2})\scm,\s+Hauteur:\s(?<height>\d{2})\scm/
  match_data = element.search('.size').text.match(pattern)
  height = match_data[:height] if match_data
  width = match_data[:width] if match_data
  lenght = match_data[:lenght] if match_data
  unless height.nil? || width.nil? || lenght.nil?
    f = Furniture.create!(
    title: title,
    description: description,
    photo: img,
    height: height,
    width: width,
    length: lenght,
    price: price,
    url: v_link,
    category: Category.find_or_create_by(name: category)
    )
    p f.inspect
  end
 end
end

doc.search('#all_products_03').each do |element|
 category = element.search('.headZeroGray b').text
 link = element.search('.bodyTextGray a').attribute('href').text.strip

 v_doc = Nokogiri::HTML(open(link).read)
 v_doc.search('.product').each do |element|
  img = base_url + element.search('img').attribute('src').text.strip
  v_link = base_url + element.search('a').attribute('href').text.strip
  title = element.search('.productTitle').text.strip
  description = element.search('.productDesp').text.strip
  price = element.search('.price').text.strip
  pattern = /^\s+Largeur:\s(?<width>\d{2})\scm,\s+Profondeur:\s(?<lenght>\d{2})\scm,\s+Hauteur:\s(?<height>\d{2})\scm/
  match_data = element.search('.size').text.match(pattern)
  height = match_data[:height] if match_data
  width = match_data[:width] if match_data
  lenght = match_data[:lenght] if match_data
  unless height.nil? || width.nil? || lenght.nil?
    f = Furniture.create!(
    title: title,
    description: description,
    photo: img,
    height: height,
    width: width,
    length: lenght,
    price: price,
    url: v_link,
    category: Category.find_or_create_by(name: category)
    )
    p f.inspect
  end
 end
end

doc.search('#all_products_04').each do |element|
 category = element.search('.headZeroGray b').text
 link = element.search('.bodyTextGray a').attribute('href').text.strip

 v_doc = Nokogiri::HTML(open(link).read)
 v_doc.search('.product').each do |element|
  img = base_url + element.search('img').attribute('src').text.strip
  v_link = base_url + element.search('a').attribute('href').text.strip
  title = element.search('.productTitle').text.strip
  description = element.search('.productDesp').text.strip
  pattern = /^\s+(?<price>\d+,?\d*)/
  match_data = element.search('.price').text.match(pattern)
  price = match_data[:price] if match_data
  pattern = /^\s+Largeur:\s(?<width>\d{2})\scm,\s+Profondeur:\s(?<lenght>\d{2})\scm,\s+Hauteur:\s(?<height>\d{2})\scm/
  match_data = element.search('.size').text.match(pattern)
  height = match_data[:height] if match_data
  width = match_data[:width] if match_data
  lenght = match_data[:lenght] if match_data
  unless height.nil? || width.nil? || lenght.nil?
    f = Furniture.create!(
    title: title,
    description: description,
    photo: img,
    height: height,
    width: width,
    length: lenght,
    price: price,
    url: v_link,
    category: Category.find_or_create_by(name: category)
    )
    p f.inspect
  end
 end
end
puts 'Finished ---) FURNITURES OK!'


puts 'Creating furnitures-wishlists...'
furniturewishlist1 = FurnituresWishlist.create!(
  wishlist: wishlist1,
  furniture: Furniture.last,
  )
furniturewishlist2 = FurnituresWishlist.create!(
  wishlist: wishlist1,
  furniture: Furniture.first,
  )
furniturewishlist3 = FurnituresWishlist.create!(
  wishlist: wishlist1,
  furniture: Furniture.fifth,
  )
furniturewishlist4 = FurnituresWishlist.create!(
  wishlist: wishlist1,
  furniture: Furniture.fourth,
  )
furniturewishlist5 = FurnituresWishlist.create!(
  wishlist: wishlist2,
  furniture: Furniture.second_to_last,
  )
furniturewishlist6 = FurnituresWishlist.create!(
  wishlist: wishlist3,
  furniture: Furniture.take ,
  )
furniturewishlist7 = FurnituresWishlist.create!(
  wishlist: wishlist4,
  furniture: Furniture.take ,
  )
puts 'Finished! ---) FURNITURES-WISHLIST OK'


puts 'Creating reviews...'
review1 = Review.create!(
  content: "La couleur est pas mal, ne sais pas si ça va coller avec la déco de la pièce",
  furnitures_wishlist: furniturewishlist1,
  )
review2 = Review.create!(
  content: "Les dimensions sont nickels pour remplacer mon vieux meuble",
  furnitures_wishlist: furniturewishlist1,
  )
review3 = Review.create!(
  content: "Le meuble donne l'impression d'être solide",
  furnitures_wishlist: furniturewishlist1,
  )
review4 = Review.create!(
  content: "Je préfère une autre couleur dommage! Mais je le garde de coté quand même",
  furnitures_wishlist: furniturewishlist1,
  )
review5 = Review.create!(
  content: "Super pour la pendaison de crémaillère, la taille et la couleur c'est parfait!",
  furnitures_wishlist: furniturewishlist2,
  )
review5 = Review.create!(
  content: "Qu'est-ce qui est jaune et qui attend? HEN... Ben Jonathan...!",
  furnitures_wishlist: furniturewishlist2,
  )
review5 = Review.create!(
  content: "J'ai pas trop le style mais si je ne trouve rien d'autre, why not...",
  furnitures_wishlist: furniturewishlist2,
  )
review5 = Review.create!(
  content: "Facile à neetoyer, belle couleur, j'adore",
  furnitures_wishlist: furniturewishlist2,
  )


puts 'Finished! ---) REVIEW OK! '


puts '#################################################################################'
puts '################################# EXCELLENT TRAVAIL #############################'
puts '#################################################################################'
