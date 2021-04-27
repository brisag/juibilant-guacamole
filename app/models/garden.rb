class Garden < ApplicationRecord
  has_many :plots
  has_many :plot_plants, through: :plots
  has_many :plants, through: :plot_plants

  # def unique_fast_plants
  #   plants
  #   .where('days_to_harvest < ?', 90)
  #   .distinct
  # end

  def unique_fast_plants_sorted_by_most_popular
    plants
    .select("plants.*, count(plants) as plant_count")
    .where('days_to_harvest < ?', 90)
    .group(:id)
    .order(plant_count: :desc)
    .distinct
  end


  # def popular_plants
  #   plants.select("plants.*, count(plants) as plant_count")
  #   .group(:id)
  #   .order(plant_count: :desc)
  #   .distinct
  # end
end
