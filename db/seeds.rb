puts 'Cleaning database...'
FurnituresWishlist.destroy_all
GuestWishlist.destroy_all
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

categories = []
base_url = "http://www.ikea.com"
doc = Nokogiri::HTML(open('http://www.ikea.com/ms/fr_FR/produits.html').read)
doc.search('#all_products_01').each do |element|
  categories = element.search('.headZeroGray b').collect {|node| node.text.strip}

 cat1_urls = ["http://www.ikea.com/fr/fr/catalog/categories/departments/living_room/10661/", "http://www.ikea.com/fr/fr/catalog/categories/departments/living_room/10662/", "http://www.ikea.com/fr/fr/catalog/categories/departments/living_room/16238/", "http://www.ikea.com/fr/fr/catalog/categories/departments/living_room/10663/", "http://www.ikea.com/fr/fr/catalog/categories/departments/living_room/10664/", "http://www.ikea.com/fr/fr/catalog/categories/departments/living_room/20926/", "http://www.ikea.com/fr/fr/catalog/categories/departments/living_room/20855/", "http://www.ikea.com/fr/fr/catalog/categories/departments/living_room/16239/"]
 cat2_urls = ["http://www.ikea.com/fr/fr/catalog/categories/departments/living_room/10382/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bedroom/10451/", "http://www.ikea.com/fr/fr/catalog/categories/departments/living_room/10384/", "http://www.ikea.com/fr/fr/catalog/categories/departments/living_room/10410/", "http://www.ikea.com/fr/fr/catalog/categories/departments/living_room/11465/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bathroom/20802/"]
 cat3_urls = ["http://www.ikea.com/fr/fr/catalog/categories/departments/living_room/10716/", "http://www.ikea.com/fr/fr/catalog/categories/departments/living_room/10717/", "http://www.ikea.com/fr/fr/catalog/categories/departments/dining/21825/", "http://www.ikea.com/fr/fr/catalog/categories/departments/dining/19145/", "http://www.ikea.com/fr/fr/catalog/categories/departments/dining/20862/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bedroom/20656-2/", "http://www.ikea.com/fr/fr/catalog/categories/departments/outdoor/21965/", "http://www.ikea.com/fr/fr/catalog/categories/departments/outdoor/21967/"]
  fail_counter = 0
  cat1_urls.each do |link|
   fail_counter += 1
   v_doc = Nokogiri::HTML(open(link).read)
   v_doc.search('.product').each do |element|
    img = base_url + element.search('img').attribute('src').text.strip
    v_link = base_url + element.search('a').attribute('href').text.strip
    title = element.search('.productTitle').text.strip
    description = element.search('.productDesp').text.strip
    ikea_price = element.search('.regularPrice').text.split(' ').first
    ikea_price.include?(",") ? price = ikea_price.gsub(",", "").to_i : price = ikea_price.gsub(/[[:space:]]/, '').to_i * 100
    pattern = /^\s+Largeur:\s(?<width>\d{1,}.?\d)\scm,\s+Profondeur:\s(?<lenght>\d{1,}.?\d)\scm,\s+Hauteur:\s(?<height>\d{1,}.?\d)\scm/
    match_data = element.search('.size').text.match(pattern)
    height = match_data[:height] if match_data
    width = match_data[:width] if match_data
    lenght = match_data[:lenght] if match_data
    unless height.nil? || width.nil? || lenght.nil?
        f = Furniture.create!(
        title: title,
        description: description,
        photo: img,
        height: height.to_i,
        width: width.to_i,
        length: lenght.to_i,
        price_cents: price,
        url: v_link,
        category: Category.find_or_create_by(name: categories[0]),
        sku: rand(36**8).to_s(36)
        )
        # p f.inspect
      end
    end
  end

  cat2_urls.each do |link|
   v_doc = Nokogiri::HTML(open(link).read)
   v_doc.search('.product').each do |element|
    img = base_url + element.search('img').attribute('src').text.strip
    v_link = base_url + element.search('a').attribute('href').text.strip
    title = element.search('.productTitle').text.strip
    description = element.search('.productDesp').text.strip
    ikea_price = element.search('.regularPrice').text.split(' ').first
    ikea_price.include?(",") ? price = ikea_price.gsub(",", "").to_i : price = ikea_price.gsub(/[[:space:]]/, '').to_i * 100
    pattern = /^\s+Largeur:\s(?<width>\d{1,}.?\d)\scm,\s+Profondeur:\s(?<lenght>\d{1,}.?\d)\scm,\s+Hauteur:\s(?<height>\d{1,}.?\d)\scm/
    match_data = element.search('.size').text.match(pattern)
    height = match_data[:height] if match_data
    width = match_data[:width] if match_data
    lenght = match_data[:lenght] if match_data
    unless height.nil? || width.nil? || lenght.nil?
        f = Furniture.create!(
        title: title,
        description: description,
        photo: img,
        height: height.to_i,
        width: width.to_i,
        length: lenght.to_i,
        price_cents: price,
        url: v_link,
        category: Category.find_or_create_by(name: categories[1]),
        sku: rand(36**8).to_s(36)
        )
        p f.inspect
      end
    end
  end

    cat3_urls.each do |link|
     v_doc = Nokogiri::HTML(open(link).read)
     v_doc.search('.product').each do |element|
      img = base_url + element.search('img').attribute('src').text.strip
      v_link = base_url + element.search('a').attribute('href').text.strip
      title = element.search('.productTitle').text.strip
      description = element.search('.productDesp').text.strip
      ikea_price = element.search('.regularPrice').text.split(' ').first
      ikea_price.include?(",") ? price = ikea_price.gsub(",", "").to_i : price = ikea_price.gsub(/[[:space:]]/, '').to_i * 100
      pattern = /^\s+Largeur:\s(?<width>\d{1,}.?\d)\scm,\s+Profondeur:\s(?<lenght>\d{1,}.?\d)\scm,\s+Hauteur:\s(?<height>\d{1,}.?\d)\scm/
      match_data = element.search('.size').text.match(pattern)
      height = match_data[:height] if match_data
      width = match_data[:width] if match_data
      lenght = match_data[:lenght] if match_data
      unless height.nil? || width.nil? || lenght.nil?
          f = Furniture.create!(
          title: title,
          description: description,
          photo: img,
          height: height.to_i,
          width: width.to_i,
          length: lenght.to_i,
          price_cents: price,
          url: v_link,
          category: Category.find_or_create_by(name: categories[2]),
          sku: rand(36**8).to_s(36)
          )
          p f.inspect
        end
      end
    end
  end


categories2 = []
base_url = "http://www.ikea.com"
doc = Nokogiri::HTML(open('http://www.ikea.com/ms/fr_FR/produits.html').read)
doc.search('#all_products_04').each do |element|
  categories2 = element.search('.headZeroGray b').collect {|node| node.text.strip}

 cat4_urls = ["http://www.ikea.com/fr/fr/catalog/categories/business/20649/", "http://www.ikea.com/fr/fr/catalog/categories/business/20652/", "http://www.ikea.com/fr/fr/catalog/categories/business/10711/", "http://www.ikea.com/fr/fr/catalog/categories/business/10551/", "http://www.ikea.com/fr/fr/catalog/categories/business/10385/", "http://www.ikea.com/fr/fr/catalog/categories/business/10712/", "http://www.ikea.com/fr/fr/catalog/categories/business/20502/", "http://www.ikea.com/fr/fr/catalog/categories/business/16195/"]
 cat5_urls = ["http://www.ikea.com/fr/fr/catalog/categories/departments/bathroom/20719/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bathroom/20723/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bathroom/20724/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bathroom/20802/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bathroom/20490/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bathroom/10736/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bathroom/10555/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bathroom/bathroom_dep_textiles/"]
 cat6_urls = ["http://www.ikea.com/fr/fr/catalog/categories/departments/secondary_storage/10397/", "http://www.ikea.com/fr/fr/catalog/categories/departments/living_room/10550/", "http://www.ikea.com/fr/fr/catalog/categories/departments/laundry/20597/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bedroom/16274/", "http://www.ikea.com/fr/fr/catalog/categories/departments/workspaces/16213/", "http://www.ikea.com/fr/fr/catalog/categories/departments/kitchen/16200/", "http://www.ikea.com/fr/fr/catalog/categories/departments/small_storage/15937/", "http://www.ikea.com/fr/fr/catalog/categories/departments/secondary_storage/18741/"]

  cat4_urls.each do |link|
   v_doc = Nokogiri::HTML(open(link).read)
   v_doc.search('.product').each do |element|
    img = base_url + element.search('img').attribute('src').text.strip
    v_link = base_url + element.search('a').attribute('href').text.strip
    title = element.search('.productTitle').text.strip
    description = element.search('.productDesp').text.strip
    ikea_price = element.search('.regularPrice').text.split(' ').first
    ikea_price.include?(",") ? price = ikea_price.gsub(",", "").to_i : price = ikea_price.gsub(/[[:space:]]/, '').to_i * 100
    pattern = /^\s+Largeur:\s(?<width>\d{1,}.?\d)\scm,\s+Profondeur:\s(?<lenght>\d{1,}.?\d)\scm,\s+Hauteur:\s(?<height>\d{1,}.?\d)\scm/
    match_data = element.search('.size').text.match(pattern)
    height = match_data[:height] if match_data
    width = match_data[:width] if match_data
    lenght = match_data[:lenght] if match_data
    unless height.nil? || width.nil? || lenght.nil?
        f = Furniture.create!(
        title: title,
        description: description,
        photo: img,
        height: height.to_i,
        width: width.to_i,
        length: lenght.to_i,
        price_cents: price,
        url: v_link,
        category: Category.find_or_create_by(name: categories2[0]),
        sku: rand(36**8).to_s(36)
        )
        p f.inspect
      end
    end
  end

  cat5_urls.each do |link|
   v_doc = Nokogiri::HTML(open(link).read)
   v_doc.search('.product').each do |element|
    img = base_url + element.search('img').attribute('src').text.strip
    v_link = base_url + element.search('a').attribute('href').text.strip
    title = element.search('.productTitle').text.strip
    description = element.search('.productDesp').text.strip
    ikea_price = element.search('.regularPrice').text.split(' ').first
    ikea_price.include?(",") ? price = ikea_price.gsub(",", "").to_i : price = ikea_price.gsub(/[[:space:]]/, '').to_i * 100
    pattern = /^\s+Largeur:\s(?<width>\d{1,}.?\d)\scm,\s+Profondeur:\s(?<lenght>\d{1,}.?\d)\scm,\s+Hauteur:\s(?<height>\d{1,}.?\d)\scm/
    match_data = element.search('.size').text.match(pattern)
    height = match_data[:height] if match_data
    width = match_data[:width] if match_data
    lenght = match_data[:lenght] if match_data
    unless height.nil? || width.nil? || lenght.nil?
        f = Furniture.create!(
        title: title,
        description: description,
        photo: img,
        height: height.to_i,
        width: width.to_i,
        length: lenght.to_i,
        price_cents: price,
        url: v_link,
        category: Category.find_or_create_by(name: categories2[1]),
        sku: rand(36**8).to_s(36)
        )
        p f.inspect
      end
    end
  end

    cat6_urls.each do |link|
     v_doc = Nokogiri::HTML(open(link).read)
     v_doc.search('.product').each do |element|
      img = base_url + element.search('img').attribute('src').text.strip
      v_link = base_url + element.search('a').attribute('href').text.strip
      title = element.search('.productTitle').text.strip
      description = element.search('.productDesp').text.strip
      ikea_price = element.search('.regularPrice').text.split(' ').first
      ikea_price.include?(",") ? price = ikea_price.gsub(",", "").to_i : price = ikea_price.gsub(/[[:space:]]/, '').to_i * 100
      pattern = /^\s+Largeur:\s(?<width>\d{1,}.?\d)\scm,\s+Profondeur:\s(?<lenght>\d{1,}.?\d)\scm,\s+Hauteur:\s(?<height>\d{1,}.?\d)\scm/
      match_data = element.search('.size').text.match(pattern)
      height = match_data[:height] if match_data
      width = match_data[:width] if match_data
      lenght = match_data[:lenght] if match_data
      unless height.nil? || width.nil? || lenght.nil?
          f = Furniture.create!(
          title: title,
          description: description,
          photo: img,
          height: height.to_i,
          width: width.to_i,
          length: lenght.to_i,
          price_cents: price,
          url: v_link,
          category: Category.find_or_create_by(name: categories2[2]),
          sku: rand(36**8).to_s(36)
          )
          p f.inspect
        end
      end
    end
end

categories3 = []
base_url = "http://www.ikea.com"
doc = Nokogiri::HTML(open('http://www.ikea.com/ms/fr_FR/produits.html').read)
doc.search('#all_products_03').each do |element|
  categories3 = element.search('.headZeroGray b').collect {|node| node.text.strip}

 cat7_urls = ["http://www.ikea.com/fr/fr/catalog/categories/departments/bedroom/19086/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bedroom/19053/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bedroom/11466/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bedroom/10452/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bedroom/16274/", "http://www.ikea.com/fr/fr/catalog/categories/departments/hallway/10455/", "http://www.ikea.com/fr/fr/catalog/categories/departments/hallway/10456/"]
 cat8_urls = ["http://www.ikea.com/fr/fr/catalog/categories/departments/bedroom/19059/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bedroom/20656-2/"]
 cat9_urls = ["http://www.ikea.com/fr/fr/catalog/categories/departments/bedroom/24823/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bedroom/24828/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bedroom/24827/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bedroom/24825/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bedroom/24826/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bedroom/24822/", "http://www.ikea.com/fr/fr/catalog/categories/departments/bedroom/24824/"]

  cat7_urls.each do |link|
   v_doc = Nokogiri::HTML(open(link).read)
   v_doc.search('.product').each do |element|
    img = base_url + element.search('img').attribute('src').text.strip
    v_link = base_url + element.search('a').attribute('href').text.strip
    title = element.search('.productTitle').text.strip
    description = element.search('.productDesp').text.strip
    ikea_price = element.search('.regularPrice').text.split(' ').first
    ikea_price.include?(",") ? price = ikea_price.gsub(",", "").to_i : price = ikea_price.gsub(/[[:space:]]/, '').to_i * 100
    pattern = /^\s+Largeur:\s(?<width>\d{1,}.?\d)\scm,\s+Profondeur:\s(?<lenght>\d{1,}.?\d)\scm,\s+Hauteur:\s(?<height>\d{1,}.?\d)\scm/
    match_data = element.search('.size').text.match(pattern)
    height = match_data[:height] if match_data
    width = match_data[:width] if match_data
    lenght = match_data[:lenght] if match_data
    unless height.nil? || width.nil? || lenght.nil?
        f = Furniture.create!(
        title: title,
        description: description,
        photo: img,
        height: height.to_i,
        width: width.to_i,
        length: lenght.to_i,
        price_cents: price,
        url: v_link,
        category: Category.find_or_create_by(name: categories3[0]),
        sku: rand(36**8).to_s(36)
        )
        p f.inspect
      end
    end
  end

  cat8_urls.each do |link|
   v_doc = Nokogiri::HTML(open(link).read)
   v_doc.search('.product').each do |element|
    img = base_url + element.search('img').attribute('src').text.strip
    v_link = base_url + element.search('a').attribute('href').text.strip
    title = element.search('.productTitle').text.strip
    description = element.search('.productDesp').text.strip
    ikea_price = element.search('.regularPrice').text.split(' ').first
    ikea_price.include?(",") ? price = ikea_price.gsub(",", "").to_i : price = ikea_price.gsub(/[[:space:]]/, '').to_i * 100
    pattern = /^\s+Largeur:\s(?<width>\d{1,}.?\d)\scm,\s+Profondeur:\s(?<lenght>\d{1,}.?\d)\scm,\s+Hauteur:\s(?<height>\d{1,}.?\d)\scm/
    match_data = element.search('.size').text.match(pattern)
    height = match_data[:height] if match_data
    width = match_data[:width] if match_data
    lenght = match_data[:lenght] if match_data
    unless height.nil? || width.nil? || lenght.nil?
        f = Furniture.create!(
        title: title,
        description: description,
        photo: img,
        height: height.to_i,
        width: width.to_i,
        length: lenght.to_i,
        price_cents: price,
        url: v_link,
        category: Category.find_or_create_by(name: categories3[1]),
        sku: rand(36**8).to_s(36)
        )
        p f.inspect
      end
    end
  end

    cat9_urls.each do |link|
     v_doc = Nokogiri::HTML(open(link).read)
     v_doc.search('.product').each do |element|
      img = base_url + element.search('img').attribute('src').text.strip
      v_link = base_url + element.search('a').attribute('href').text.strip
      title = element.search('.productTitle').text.strip
      description = element.search('.productDesp').text.strip
      ikea_price = element.search('.regularPrice').text.split(' ').first
      ikea_price.include?(",") ? price = ikea_price.gsub(",", "").to_i : price = ikea_price.gsub(/[[:space:]]/, '').to_i * 100
      pattern = /^\s+Largeur:\s(?<width>\d{1,}.?\d)\scm,\s+Profondeur:\s(?<lenght>\d{1,}.?\d)\scm,\s+Hauteur:\s(?<height>\d{1,}.?\d)\scm/
      match_data = element.search('.size').text.match(pattern)
      height = match_data[:height] if match_data
      width = match_data[:width] if match_data
      lenght = match_data[:lenght] if match_data
      unless height.nil? || width.nil? || lenght.nil?
          f = Furniture.create!(
          title: title,
          description: description,
          photo: img,
          height: height.to_i,
          width: width.to_i,
          length: lenght.to_i,
          price_cents: price,
          url: v_link,
          category: Category.find_or_create_by(name: categories3[2]),
          sku: rand(36**8).to_s(36)
          )
          p f.inspect
        end
      end
    end
end

categories4 = []
base_url = "http://www.ikea.com"
doc = Nokogiri::HTML(open('http://www.ikea.com/ms/fr_FR/produits.html').read)
doc.search('#all_products_02').each do |element|
  categories4 = element.search('.headZeroGray b').collect {|node| node.text.strip}

 cat10_urls = ["http://www.ikea.com/fr/fr/catalog/categories/departments/ikea_kitchens/23598/", "http://www.ikea.com/fr/fr/catalog/categories/departments/ikea_kitchens/16200/", "http://www.ikea.com/fr/fr/catalog/categories/departments/ikea_kitchens/10471/"]

  cat10_urls.each do |link|
   v_doc = Nokogiri::HTML(open(link).read)
   v_doc.search('.product').each do |element|
    img = base_url + element.search('img').attribute('src').text.strip
    v_link = base_url + element.search('a').attribute('href').text.strip
    title = element.search('.productTitle').text.strip
    description = element.search('.productDesp').text.strip
    ikea_price = element.search('.regularPrice').text.split(' ').first
    ikea_price.include?(",") ? price = ikea_price.gsub(",", "").to_i : price = ikea_price.gsub(/[[:space:]]/, '').to_i * 100
    pattern = /^\s+Largeur:\s(?<width>\d{1,}.?\d)\scm,\s+Profondeur:\s(?<lenght>\d{1,}.?\d)\scm,\s+Hauteur:\s(?<height>\d{1,}.?\d)\scm/
    match_data = element.search('.size').text.match(pattern)
    height = match_data[:height] if match_data
    width = match_data[:width] if match_data
    lenght = match_data[:lenght] if match_data
    unless height.nil? || width.nil? || lenght.nil?
        f = Furniture.create!(
        title: title,
        description: description,
        photo: img,
        height: height.to_i,
        width: width.to_i,
        length: lenght.to_i,
        price_cents: price,
        url: v_link,
        category: Category.find_or_create_by(name: categories4[1]),
        sku: rand(36**8).to_s(36)
        )
        p f.inspect
      end
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
guestwishlist1 = GuestWishlist.create!(
  wishlist: wishlist1,
  user: User.first,
  email: "contact@copas.coop"
  )
puts 'Creating guest-wishlist...'


puts 'Finished! ---) GUEST-WISHLIST OK'

puts 'Creating reviews...'
review1 = Review.create!(
  content: "La couleur est pas mal, ne sais pas si ça va coller avec la déco de la pièce",
  furnitures_wishlist: furniturewishlist1,
  user: user1
  )
review2 = Review.create!(
  content: "Les dimensions sont nickels pour remplacer mon vieux meuble",
  furnitures_wishlist: furniturewishlist1,
  user: user2
  )
review3 = Review.create!(
  content: "Le meuble donne l'impression d'être solide",
  furnitures_wishlist: furniturewishlist1,
  user: user2
  )
review4 = Review.create!(
  content: "Je préfère une autre couleur dommage! Mais je le garde de coté quand même",
  furnitures_wishlist: furniturewishlist1,
  user: user3
  )
review5 = Review.create!(
  content: "Super pour la pendaison de crémaillère, la taille et la couleur c'est parfait!",
  furnitures_wishlist: furniturewishlist2,
  user: user4
  )
review5 = Review.create!(
  content: "Qu'est-ce qui est jaune et qui attend? HEN... Ben Jonathan...!",
  furnitures_wishlist: furniturewishlist2,
  user: user5
  )
review5 = Review.create!(
  content: "J'ai pas trop le style mais si je ne trouve rien d'autre, why not...",
  furnitures_wishlist: furniturewishlist2,
  user: user2
  )
review5 = Review.create!(
  content: "Facile à neetoyer, belle couleur, j'adore",
  furnitures_wishlist: furniturewishlist2,
  user: user1
  )


puts 'Finished! ---) REVIEW OK! '


puts '#################################################################################'
puts '################################# EXCELLENT TRAVAIL #############################'
puts '#################################################################################'
