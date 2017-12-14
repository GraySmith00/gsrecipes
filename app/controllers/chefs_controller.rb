class ChefsController < ApplicationController
  before_action :set_chef, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @chef = Chef.new
  end
  
  def create
    @chef = Chef.create(chef_params)
    
    if @chef.save
      session[:chef_id] = @chef.id
      flash[:success] = "Welcome #{@chef.chefname.capitalize}, you can now create and share your own recipes!"
      redirect_to chef_path(@chef.id)
    else
      render 'new'
    end
  end
  
  def show
    #@chef = Chef.find(params[:id])
    @recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
  end
  
  def edit
    #@chef = Chef.find(params[:id])
  end
  
  def update
    #@chef = Chef.find(params[:id])
    
    if @chef.update(chef_params)
      flash[:success] = "Your account has been successfully updated."
      redirect_to chef_path(@chef.id)
    else
      render 'edit'
    end
  end
  
  def destroy
    #@chef = Chef.find(params[:id])
    
    @chef.destroy
    flash[:success] = "Chef has been successfully removed."
    redirect_to chefs_path
  end
  
  
  
  private
  
    def set_chef
      @chef = Chef.find(params[:id])
    end
  
    def chef_params
      params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
    end
    
    def require_same_user
      if current_chef != @chef
        flash[:danger] = "You can only edit your own account."
        redirect_to chefs_path
      end
    end
  
end