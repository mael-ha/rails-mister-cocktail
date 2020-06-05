class DosesController < ApplicationController
  before_action :set_dose, only: [:show, :edit, :update, :destroy]
  def index
    @doses = Dose.all
  end

  def show
  end

  def new
    @dose = Dose.new
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def create
    @dose = Dose.new(dose_params)
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to cocktail_path(@cocktail), notice: 'Dose successfully created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @dose.update(dose_params)
    @cocktail = Cocktail.find(@dose.cocktail_id)
    redirect_to cocktail_path(@cocktail), notice: 'Dose successfully updated'
  end

  def destroy
    @cocktail = Cocktail.find(@dose.cocktail_id)
    @dose.destroy
    redirect_to cocktail_path(@cocktail), notice: 'Dose successfully deleted'
  end

  private
  def set_dose
    @dose = Dose.find(params[:id])
  end
  def dose_params
    params.require(:dose).permit(:description, :ingredient_id, :cocktail_id)
  end
end
