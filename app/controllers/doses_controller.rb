class DosesController < ApplicationController
  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @new_dose = Dose.new(dose_params)
    @new_dose.cocktail = @cocktail

    @cocktail_doses = Dose.where(cocktail: @cocktail)
    @ingredients = Ingredient.all

    @cocktail_reviews = Review.where(cocktail: @cocktail)
    @new_review = Review.new

    if @new_dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render 'cocktails/show'
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @cocktail = Cocktail.find(@dose.cocktail.id)

    @dose.destroy

    redirect_to cocktail_path(@cocktail)
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end
