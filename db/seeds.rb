# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@garden_1 = Garden.create!(name: 'Turing Community Garden', organic: true)

@plot_1 = @garden_1.plots.create!(number: 101, size: 'Large', direction: 'East')
@plot_2 = @garden_1.plots.create!(number: 201, size: 'Large', direction: 'West')
@plot_3 = @garden_1.plots.create!(number: 301, size: 'Medium', direction: 'East')
@plot_4 = @garden_1.plots.create!(number: 401, size: 'Small', direction: 'North')

@plant_1 = Plant.create!(name: 'Blue', description: "one description", days_to_harvest: 90)
@plant_2 = Plant.create!(name: 'Yellow', description: "two description", days_to_harvest: 20)
@plant_3 = Plant.create!(name: 'Green', description: "three description", days_to_harvest: 180)
@plant_4 = Plant.create!(name: 'Purple', description: "four description", days_to_harvest: 15)
@plant_5 = Plant.create!(name: 'Mystery', description: "five description", days_to_harvest: 30)

@plot_plant_1 = PlotPlant.create(plot: @plot_1, plant: @plant_1)
@plot_plant_2 = PlotPlant.create(plot: @plot_1, plant: @plant_2)
@plot_plant_3 = PlotPlant.create(plot: @plot_2, plant: @plant_3)
@plot_plant_4 = PlotPlant.create(plot: @plot_2, plant: @plant_4)
@plot_plant_5 = PlotPlant.create(plot: @plot_3, plant: @plant_5)
@plot_plant_6 = PlotPlant.create(plot: @plot_3, plant: @plant_1)
@plot_plant_7 = PlotPlant.create(plot: @plot_4, plant: @plant_2)
@plot_plant_8 = PlotPlant.create(plot: @plot_4, plant: @plant_3)
