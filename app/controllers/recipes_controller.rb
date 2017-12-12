class RecipesController < ApplicationController
  
  def index
    @recipes = Recipe.all
  end
  
  def show
    @recipe = Recipe.find(params[:id])
    @chef = @recipe.chef
  end
  
  def new
    @recipe = Recipe.new 
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.first
    
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_path(@recipe), notice: "Your recipe has been created!" }
      else
        format.html { render 'new' }
      end
    end
  end
  
  private
  
    def recipe_params
      params.require(:recipe).permit(:name, :description)
    end
  
end