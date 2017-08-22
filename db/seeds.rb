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

puts 'Creating categories...'
category1 = Category.create!(name: "Bureaux")
category2 = Category.create!(name: "Rangements salle de bain")
category3 = Category.create!(name: "Rangement vêtements")
category4 = Category.create!(name: "Petit rangement")
category5 = Category.create!(name: "Meubles de rangement")
category6 = Category.create!(name: "Tables")
category7 = Category.create!(name: "Meubles TV et média")
puts 'Finished! ---) CATEGORIES OK'

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
  title: "Le bureau",
  description: "trouver le nouveau bureau de travail",
  user: user1,
  )
wishlist4 = Wishlist.create!(
  title: "Le salon",
  description: "Trouver un table basse",
  user: user2,
  )
wishlist5 = Wishlist.create!(
  title: "Le bureau",
  description: "Trouver une  nouvelle étagère",
  user: user3,
  )
wishlist6 = Wishlist.create!(
  title: "Le salon",
  description: "Trouver un nouveau meuble tv",
  user: user4,
  )
puts 'Finished! ---) WISHLIST OK'


puts 'Creating furnitures...'
furniture1 = Furniture.create!(
  title: "MICKE",
  description: "Avec la série MICKE, j’ai voulu simplifier notre utilisation actuelle des ordinateurs et téléphones portables. En facilitant, par exemple, le contact avec les amis, les divers téléchargements, le travail ou encore l’impression de billets. Ce meuble comporte de nombreux détails astucieux, comme le passe-câbles qui permet de les dissimuler, ou les dimensions des éléments (de hauteur et profondeur identiques) grâce auxquelles chacun peut créer sa propre combinaison.",
  photo: "http://www.ikea.com/fr/fr/images/products/micke-bureau-brun__0172826_PE327016_S4.JPG",
  height: "75",
  width: "50",
  length: "73",
  price: "39",
  url: "http://www.ikea.com/fr/fr/catalog/products/20244747/",
  category: category1,
  )
furniture2 = Furniture.create!(
  title: "ALEX",
  description: "Système intégré pour regrouper les câbles, qui restent hors de vue mais à portée de main.",
  photo: "http://www.ikea.com/fr/fr/images/products/alex-bureau-gris__0242200_PE381727_S4.JPG",
  height: "76",
  width: "60",
  length: "131",
  price: "149",
  url: "http://www.ikea.com/fr/fr/catalog/products/90260710/",
  category: category1,
  )
furniture3 = Furniture.create!(
  title: "ALEX",
  description: "Système intégré pour regrouper les câbles, qui restent hors de vue mais à portée de main.",
  photo: "http://www.ikea.com/fr/fr/images/products/alex-bureau-gris__0242200_PE381727_S4.JPG",
  height: "78",
  width: "48",
  length: "80",
  price: "64",
  url: "http://www.ikea.com/fr/fr/catalog/products/80103344/",
  category: category3,
  )
furniture4 = Furniture.create!(
  title: "MALM",
  description: "La maison doit être un lieu sûr pour chaque membre de la famille. C'est pourquoi une fixation de sécurité est incluse afin de fixer la commode au mur.",
  photo: "http://www.ikea.com/fr/fr/images/products/malm-commode-tiroirs-brun__74485_PE191628_S4.JPG",
  height: "78",
  width: "48",
  length: "80",
  price: "64",
  url: "http://www.ikea.com/fr/fr/catalog/products/80103344/",
  category: category3,
  )
furniture5 = Furniture.create!(
  title: "BESTÅ",
  description: "Vous pouvez facilement dissimuler les câbles de la TV et tout autre équipement mais en les gardant à portée de main grâce aux ouvertures pratiquées au dos du banc TV.",
  photo: "http://www.ikea.com/fr/fr/images/products/besta-banc-tv__0341772_PE529344_S4.JPG",
  height: "48",
  width: "40",
  length: "120",
  price: "85",
  url: "http://www.ikea.com/fr/fr/catalog/products/S89061226/",
  category: category7,
  )
furniture6 = Furniture.create!(
  title: "MICKE",
  description: "Avec la série MICKE, j’ai voulu simplifier notre utilisation actuelle des ordinateurs et téléphones portables. En facilitant, par exemple, le contact avec les amis, les divers téléchargements, le travail ou encore l’impression de billets. Ce meuble comporte de nombreux détails astucieux, comme le passe-câbles qui permet de les dissimuler, ou les dimensions des éléments (de hauteur et profondeur identiques) grâce auxquelles chacun peut créer sa propre combinaison.",
  photo: "http://www.ikea.com/fr/fr/images/products/micke-bureau-brun__0172826_PE327016_S4.JPG",
  height: "75",
  width: "50",
  length: "73",
  price: "39",
  url: "http://www.ikea.com/fr/fr/catalog/products/20244747/",
  category: category1,
  )
furniture7 = Furniture.create!(
  title: "ALEX",
  description: "Système intégré pour regrouper les câbles, qui restent hors de vue mais à portée de main.",
  photo: "http://www.ikea.com/fr/fr/images/products/alex-bureau-gris__0242200_PE381727_S4.JPG",
  height: "76",
  width: "60",
  length: "131",
  price: "149",
  url: "http://www.ikea.com/fr/fr/catalog/products/90260710/",
  category: category1,
  )
furniture8 = Furniture.create!(
  title: "STOLM",
  description: "Système intégré pour regrouper les câbles, qui restent hors de vue mais à portée de main.",
  photo: "http://www.ikea.com/fr/fr/images/products/alex-bureau-gris__0242200_PE381727_S4.JPG",
  height: "78",
  width: "48",
  length: "80",
  price: "64",
  url: "http://www.ikea.com/fr/fr/catalog/products/80103344/",
  category: category3,
  )
furniture9 = Furniture.create!(
  title: "MALM",
  description: "La maison doit être un lieu sûr pour chaque membre de la famille. C'est pourquoi une fixation de sécurité est incluse afin de fixer la commode au mur.",
  photo: "http://www.ikea.com/fr/fr/images/products/malm-commode-tiroirs-brun__74485_PE191628_S4.JPG",
  height: "78",
  width: "48",
  length: "80",
  price: "64",
  url: "http://www.ikea.com/fr/fr/catalog/products/80103344/",
  category: category3,
  )
furniture10 = Furniture.create!(
  title: "BESTA",
  description: "Vous pouvez facilement dissimuler les câbles de la TV et tout autre équipement mais en les gardant à portée de main grâce aux ouvertures pratiquées au dos du banc TV.",
  photo: "http://www.ikea.com/fr/fr/images/products/besta-banc-tv__0341772_PE529344_S4.JPG",
  height: "48",
  width: "40",
  length: "120",
  price: "85",
  url: "http://www.ikea.com/fr/fr/catalog/products/S89061226/",
  category: category7,
  )
puts 'Finished ---) FURNITURES OK!'


puts 'Creating furnitures-wishlists...'
furniturewishlist1 = FurnituresWishlist.create!(
  wishlist: wishlist1,
  furniture: furniture1,
  )
furniturewishlist2 = FurnituresWishlist.create!(
  wishlist: wishlist1,
  furniture: furniture2,
  )
furniturewishlist3 = FurnituresWishlist.create!(
  wishlist: wishlist1,
  furniture: furniture3,
  )
furniturewishlist4 = FurnituresWishlist.create!(
  wishlist: wishlist1,
  furniture: furniture4,
  )
furniturewishlist5 = FurnituresWishlist.create!(
  wishlist: wishlist2,
  furniture: furniture3,
  )
furniturewishlist6 = FurnituresWishlist.create!(
  wishlist: wishlist3,
  furniture: furniture5,
  )
furniturewishlist7 = FurnituresWishlist.create!(
  wishlist: wishlist4,
  furniture: furniture10,
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
