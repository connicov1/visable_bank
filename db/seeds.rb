# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Dir[Rails.root.join('db', 'seeds', '*.json')].sort.each do |path|
  model_name = path[/[\w-]+\.json/].gsub('.json', '')
  model_data = JSON.parse(File.read(path))

  model_data.each do |data|
    model_name.singularize.capitalize.constantize.find_or_create_by!(data)
  end
end

puts 'Enjoy :)'
