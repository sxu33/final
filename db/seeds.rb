require 'faker'

# Seed Categories
categories = ["Clothing", "Accessories", "Footwear"]
categories.each do |category_name|
  Category.find_or_create_by!(name: category_name)
end

# Seed Products
10.times do
  category = Category.order('RANDOM()').first
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    price: Faker::Commerce.price(range: 10.0..100.0),
    category: category,
    on_sale: [true, false].sample,
    new: [true, false].sample,
    recently_updated: [true, false].sample
  )
end

# Seed About and Contact pages
About.find_or_create_by!(title: "About Us") do |about|
  about.content = "Winnipeg Fashion Hub is a well-established retail business located in Winnipeg, Manitoba. With a team of 20 dedicated employees, the company has been in operation for over 10 years. Winnipeg Fashion Hub specializes in selling high-quality fashion apparel including clothing, accessories, and footwear. The business currently sells its products through a physical retail store and a basic online catalog, and now seeks to expand its online presence with a comprehensive e-commerce platform."
end

Contact.find_or_create_by!(title: "Contact Us") do |contact|
  contact.content = "If you have any questions or need further information, please feel free to contact us at contact@winnipegfashionhub.com or call us at (204) 123-4567. Our customer service team is available Monday through Friday, 9:00 AM to 5:00 PM."
end
