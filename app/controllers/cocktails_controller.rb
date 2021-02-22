class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all

    if params[:search]
      @query = query_params[:query]
      @cocktails = Cocktail.where("lower(name) LIKE lower(?)", "%#{@query}%")
    end

    # Video pexels
    # pexels_key = "563492ad6f9170000100000138c8f4c57b1c4c69a53d72daaeb561d3" # Your pexels authenticator key
    # client = Pexels::Client.new(pexels_key) # Set up the client

    # pexels_json_parsed = client.videos.search('waves') # Search for videos with keyword "waves", return you 15 videos
    # @video_url = pexels_json_parsed.videos[0].files[0].link # Take the first video
    # @video_type = pexels_json_parsed.videos[0].files[0].file_type

    @video_url = "app/assets/videos/video_test.mp4"
    @video_type = 'video/mp4'
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
    params.require(:cocktail).permit(:name, :description)
  end

  def query_params
    params.require(:search).permit(:query)
  end
end
