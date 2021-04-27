class Garden < ApplicationRecord
  has_many :plots
  has_many :plot_plants, through: :plots
  has_many :plants, through: :plot_plants

  def unique_fast_plants
    plants
    .where('days_to_harvest < ?', 90)
    .distinct
  end
end
