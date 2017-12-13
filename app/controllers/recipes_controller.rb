class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  
  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
  end
  
  def show
    #@recipe = Recipe.find(params[:id])
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
  
  def edit
    #@recipe = Recipe.find(params[:id])
  end
  
  def update
    #@recipe = Recipe.find(params[:id])
    
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe has been succesfully updated!"
      redirect_to recipe_path(@recipe.id)
    else
      render 'edit'
    end
  end
  
  def destroy
    #@recipe = Recipe.find(params[:id])
    
    @recipe.destroy
    flash[:success] = "Recipe has been succesfully removed."
    redirect_to recipes_path
  end
  
  private
  
    def recipe_params
      params.require(:recipe).permit(:name, :description, :chef_id)
    end
    
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
    

  
end