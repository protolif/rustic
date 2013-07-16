class ComputersController < ApplicationController
  def index
    @computers = Computer.all.order("make").paginate(page: params[:page], per_page: 30)
  end

  def show
    @computer = Computer.find params[:id]
  end

  def update
    # @computer = Computer.find params[:id]
    # if @computer.update_attributes(params[:computer])
    #   redirect_to @computer
    # end
    raise params.to_yaml
  end
end
