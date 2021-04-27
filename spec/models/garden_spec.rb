require 'rails_helper'

RSpec.describe Garden do
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
    @plot_plant_3 = PlotPlant.create(plot: @plot_2, plant: @plant_2)
    @plot_plant_4 = PlotPlant.create(plot: @plot_2, plant: @plant_4)
    @plot_plant_5 = PlotPlant.create(plot: @plot_3, plant: @plant_5)
    @plot_plant_6 = PlotPlant.create(plot: @plot_3, plant: @plant_1)
    @plot_plant_7 = PlotPlant.create(plot: @plot_4, plant: @plant_2)
    @plot_plant_8 = PlotPlant.create(plot: @plot_4, plant: @plant_3)
    @plot_plant_7 = PlotPlant.create(plot: @plot_4, plant: @plant_5)

  end

  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plot_plants).through(:plots) }
    it { should have_many(:plants).through(:plot_plants) }
  end

  describe 'instance methods' do
    describe 'unique_fast_plants' do
      it 'list distinct plants that are harvested less than 90 days' do
        expect(@garden_1.unique_fast_plants).to eq([@plant_2, @plant_4, @plant_5])
        expect(@garden_1.unique_fast_plants).to_not eq([@plant_2, @plant_2, @plant_4, @plant_5, @plant_5])
        #data above has plant 2 and plant 5 listed twice. we do not want to list them out twice, thus distinct is used.

        expect(@garden_1.unique_fast_plants).to_not eq([@plant_1, @plant_3])
        expect(@plant_3.days_to_harvest).to eq(180)
        expect(@plant_1.days_to_harvest).to eq(90)
        expect(@plant_2.days_to_harvest).to eq(20)
      end
    end
  end
end
