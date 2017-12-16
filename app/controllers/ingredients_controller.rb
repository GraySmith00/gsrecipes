class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:show, :index]
  
  def index
    @ingredients = Ingredient.paginate(page: params[:page], per_page: 5)
  end
  
  def show
   #@ingredient = Ingredient.find(params[:id])
  end
  
  def new
    @ingredient = Ingredient.new
  end
  
  def create
    @ingredient = Ingredient.new(ingredient_params)
    
    if @ingredient.save
      flash[:success] = "Your ingredient has been created!"
      redirect_to ingredients_path
    else
      render "new"
    end
  end
  
  def edit
    #@ingredient = Ingredient.find(params[:id])
  end
  
  def update
    #@ingredient = Ingredient.find(params[:id])
    if @ingredient.update(ingredient_params)
      flash[:success] = "Your ingredient has been updated."
      redirect_to ingredients_path
    else
      render "new"
    end
  end
  
  def destroy
    @ingredient.destroy
    flash[:success] = "#{@ingredient.name} has been removed."
    redirect_to ingredients_path
  end
  
  
  private
  
    def ingredient_params
      params.require(:ingredient).permit(:name)
    end
    
    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end
    
    def require_admin
      if !logged_in? || (logged_in? && !current_chef.admin?)
        flash[:danger] = "Only admins have that permission."
        redirect_to root_path
      end
    end
  
  
  
  
  
  
end