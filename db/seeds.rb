require 'faker'

# Clear existing data
Product.delete_all
Category.delete_all
About.delete_all
Contact.delete_all

# Seed Categories
categories = ["Clothing", "Accessories", "Footwear", "Hats", "Bags", "Jewelry", "Watches", "Sunglasses"]
categories.each do |category_name|
  Category.find_or_create_by!(name: category_name)
end

# Seed Products
100.times do
  category = Category.order('RANDOM()').first
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    price: Faker::Commerce.price(range: 10.0..100.0),
    category: category,
    on_sale: [true, false].sample,
    
  )
end

provinces = [
  { name: 'Alberta', gst: 0.05, pst: 0.0, hst: 0.0 },
  { name: 'British Columbia', gst: 0.05, pst: 0.07, hst: 0.0 },
  { name: 'Manitoba', gst: 0.05, pst: 0.07, hst: 0.0 },
  { name: 'New Brunswick', gst: 0.0, pst: 0.0, hst: 0.15 },
  { name: 'Newfoundland and Labrador', gst: 0.0, pst: 0.0, hst: 0.15 },
  { name: 'Nova Scotia', gst: 0.0, pst: 0.0, hst: 0.15 },
  { name: 'Ontario', gst: 0.0, pst: 0.0, hst: 0.13 },
  { name: 'Prince Edward Island', gst: 0.0, pst: 0.0, hst: 0.15 },
  { name: 'Quebec', gst: 0.05, pst: 0.09975, hst: 0.0 },
  { name: 'Saskatchewan', gst: 0.05, pst: 0.06, hst: 0.0 },
  { name: 'Northwest Territories', gst: 0.05, pst: 0.0, hst: 0.0 },
  { name: 'Nunavut', gst: 0.05, pst: 0.0, hst: 0.0 },
  { name: 'Yukon', gst: 0.05, pst: 0.0, hst: 0.0 }
]

provinces.each do |province_data|
  province = Province.create!(name: province_data[:name])
  TaxRate.create!(province: province, gst: province_data[:gst], pst: province_data[:pst], hst: province_data[:hst])
end



# Seed About and Contact pages
About.find_or_create_by!(title: "About Us") do |about|
  about.content = "Winnipeg Fashion Hub is a well-established retail business located in Winnipeg, Manitoba. With a team of 20 dedicated employees, the company has been in operation for over 10 years. Winnipeg Fashion Hub specializes in selling high-quality fashion apparel including clothing, accessories, and footwear. The business currently sells its products through a physical retail store and a basic online catalog, and now seeks to expand its online presence with a comprehensive e-commerce platform."
end

Contact.find_or_create_by!(title: "Contact Us") do |contact|
  contact.content = "If you have any questions or need further information, please feel free to contact us at contact@winnipegfashionhub.com or call us at (204) 123-4567. Our customer service team is available Monday through Friday, 9:00 AM to 5:00 PM."
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?