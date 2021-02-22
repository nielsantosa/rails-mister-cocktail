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

  def edit
    set_cocktail
  end

  def update
    set_cocktail
    if @cocktail.update(cocktail_params)
      redirect_to cocktails_path
    else
      render :edit
    end
  end

  def destroy
    @cocktail = Cocktail.find(params[:id])
    @cocktail.destroy

    redirect_to cocktails_path
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :description, :photo)
  end

  def query_params
    params.require(:search).permit(:query)
  end
end
