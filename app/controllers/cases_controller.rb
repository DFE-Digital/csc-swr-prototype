class CasesController < ApplicationController

  def index
  end
  
  def new
  end
  
  def create
    @case = Case.new(name: params[:name])
    @case.image.attach(params[:image])
    @case.save
  end

  def show
    @case = Case.find(params[:id])
  end
end
