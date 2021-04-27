require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit the flights index page' do
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

      visit plots_path
    end

    it 'I see a list of all plot numbers' do
      # save_and_open_page
      within("#plot-#{@plot_1.id}") do
        expect(page).to have_content(@plot_1.number)
      end

      within("#plot-#{@plot_2.id}") do
        expect(page).to have_content(@plot_2.number)
      end

      within("#plot-#{@plot_3.id}") do
        expect(page).to have_content(@plot_3.number)
      end

      within("#plot-#{@plot_4.id}") do
        expect(page).to have_content(@plot_4.number)
      end
    end

    it "under each plot number I see names of all that plot's plants" do
      within("#plot-#{@plot_1.id}") do
        expect(page).to have_content(@plot_1.number)
        expect(page).to have_content(@plant_1.name)
        expect(page).to have_content(@plant_2.name)

      end

      within("#plot-#{@plot_2.id}") do
        expect(page).to have_content(@plot_2.number)
        expect(page).to have_content(@plant_3.name)
        expect(page).to have_content(@plant_4.name)

      end

      within("#plot-#{@plot_3.id}") do
        expect(page).to have_content(@plot_3.number)
        expect(page).to have_content(@plant_5.name)
        expect(page).to have_content(@plant_1.name)

      end

      within("#plot-#{@plot_4.id}") do
        expect(page).to have_content(@plot_4.number)
        expect(page).to have_content(@plant_2.name)
        expect(page).to have_content(@plant_3.name)
      end
    end

    describe "Next to each plant's name, I see a link to remove that plant from that plot" do
      it "shows a remove button" do
        within("#plot-#{@plot_1.id}") do
          within "#plant-#{@plant_1.id}" do
            expect(page).to have_button("Remove #{@plant_1.name}")
          end
        end

        within("#plot-#{@plot_3.id}") do
          within "#plant-#{@plant_1.id}" do
            expect(page).to have_button("Remove #{@plant_1.name}")
          end
        end
      end
      describe "When I click on that link," do
        it  "I'm returned to the plots index page, And I no longer see that plant listed under that plot" do
          within("#plot-#{@plot_1.id}") do
            within "#plant-#{@plant_1.id}" do
              expect(page).to have_button("Remove #{@plant_1.name}")
              click_button("Remove #{@plant_1.name}")
            end
            expect(current_path).to eq(plots_path)
            expect(page).to_not have_content(@plant_1.name)
            expect(page).to have_content(@plant_2.name)
          end

          within("#plot-#{@plot_2.id}") do
            within "#plant-#{@plant_3.id}" do
              expect(page).to have_button("Remove #{@plant_3.name}")
              click_button("Remove #{@plant_3.name}")
            end
            expect(current_path).to eq(plots_path)
            expect(page).to_not have_content(@plant_3.name)
            expect(page).to have_content(@plant_4.name)
          end
        end
      end
    end
  end
end
