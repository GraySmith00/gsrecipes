class RecipesController < ApplicationController
  
  def index
    @recipes = Recipe.all.by_order_desc
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
    
    if @recipe.save
      flash[:success] = "Your recipe has been created!"
      redirect_to recipe_path(@recipe.id)
    else
      render 'new' 
    end
   
  end
  
  private
  
    def recipe_params
      params.require(:recipe).permit(:name, :description)
    end
    

  
end