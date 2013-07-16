class ComputersController < ApplicationController
  def index
    @computers = Computer.all.order("make").paginate(page: params[:page], per_page: 30)
  end

  def show
    @computer = Computer.find params[:id]
  end

  def update
    @computer = Computer.find params[:id]
    if @computer
      if @computer.update_attributes!(computer_params)
        redirect_to @computer
      else
        raise 'herp'.inspect
      end
    else
      raise 'derp'.inspect
    end
  end

  private
    def computer_params
      params.require(:computer).permit(:make, :model, :serial, :form_factor, :charger, :location)
    end
  # end private
end
