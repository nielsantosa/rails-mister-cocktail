class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all

    if params[:search]
      @query = query_params[:query]
      @cocktails = Cocktail.where("lower(name) LIKE lower(?)", "%#{@query}%")
    end
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @cocktail_doses = Dose.where(cocktail: @cocktail)
    @new_dose = Dose.new
    @ingredients = Ingredient.all

    @cocktail_reviews = Review.where(cocktail: @cocktail)
    @new_review = Review.new
  end

  def new
    @new_cocktail = Cocktail.new
  end

  def create
    @new_cocktail = Cocktail.new(cocktail_params)
    if @new_cocktail.save
      redirect_to cocktails_path
    else
      render :new
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :description)
  end

  def query_params
    params.require(:search).permit(:query)
  end
end
