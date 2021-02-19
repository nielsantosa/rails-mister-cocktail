class ReviewsController < ApplicationController
  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @new_review = Review.new(review_params)
    @new_review.cocktail = @cocktail

    @new_dose = Dose.new
    @cocktail_doses = Dose.where(cocktail: @cocktail)
    @cocktail_reviews = Review.where(cocktail: @cocktail)
    @ingredients = Ingredient.all

    if @new_review.save
      redirect_to cocktail_path(@cocktail)
    else
      render 'cocktails/show'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @cocktail = Cocktail.find(@review.cocktail.id)

    @review.destroy

    redirect_to cocktail_path(@cocktail)
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
