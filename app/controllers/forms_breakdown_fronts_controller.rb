class FormsBreakdownFrontsController < ApplicationController

  #####################################
  def index
    @forms_breakdown_fronts = Forms::BreakdownFront.all
  end

  #####################################
  def show
    @forms_breakdown_front = Forms::BreakdownFront.find(params[:id])
  end

  #####################################
  def new
    @forms_breakdown_front = Forms::BreakdownFront.new
  end

  #####################################
  def edit
    @forms_breakdown_front = Forms::BreakdownFront.find(params[:id])
  end

  #####################################
  def create
    @forms_breakdown_front = Forms::BreakdownFront.new(params[:forms_breakdown_front])
    @forms_breakdown_front.save
    flash[:notice] = "Breakdown was successfully created."
    render :action => 'show'
  end

  #####################################
  def update
    @forms_breakdown_front = Forms::BreakdownFront.find(params[:id])
    @forms_breakdown_front.update_attributes(params[:forms_breakdown_front])
    flash[:notice] = "Breakdown was successfully updated."
    render :action => 'show'
  end

  #####################################
  def destroy
    @forms_breakdown_front = Forms::BreakdownFront.find(params[:id])
    @forms_breakdown_front.destroy
    redirect_to :action => 'index'
  end
end
