class PlotPlantsController < ApplicationController
  def destroy
    plot_plant = PlotPlant.find_by(plot_id: params[:id], plant_id: params[:format])
    plot_plant.destroy
    redirect_to plots_path
  end
end
