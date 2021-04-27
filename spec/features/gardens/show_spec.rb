require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe "When I visit a Gardens Show page" do
    before :each do
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


      visit garden_path(@garden_1)
    end

    it "I see the garden's 'name' and 'organic' attributes," do
      expect(page).to have_content(@garden_1.name)
      expect(page).to have_content(@garden_1.organic)
    end

    it "And I see that this list only includes plants (no duplicate names) that take less than 100 days to harvest" do
      expect(page).to have_content(@plant_2.name)
      expect(page).to have_content(@plant_4.name)
      expect(page).to have_content(@plant_5.name)
      expect(page).to_not have_content(@plant_1.name)
      expect(page).to_not have_content(@plant_3.name)
    end

    it "And I see that this list is ordered" do
      expect(@plant_2.name).to appear_before(@plant_4.name)
      expect(@plant_4.name).to appear_before(@plant_5.name)
    end
  end
end
