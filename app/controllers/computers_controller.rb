class ComputersController < ApplicationController
  def index
    @computers = Computer.all.order("make").paginate(page: params[:page], per_page: 30)
  end
end
