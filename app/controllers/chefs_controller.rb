class ChefsController < ApplicationController
  
  def new
    @chef = Chef.new
  end
  
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 5)
  end
  
  def create
    @chef = Chef.create(chef_params)
    
    if @chef.save
      flash[:success] = "Welcome #{@chef.chefname.capitalize}, you can now create and share your own recipes!"
      redirect_to chef_path(@chef.id)
    else
      render 'new'
    end
  end
  
  def show
    @chef = Chef.find(params[:id])
    @recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
  end
  
  def edit
    @chef = Chef.find(params[:id])
  end
  
  def update
    @chef = Chef.find(params[:id])
    
    if @chef.update(chef_params)
      flash[:success] = "Your account has been successfully updated."
      redirect_to chef_path(@chef.id)
    else
      render 'edit'
    end
  end
  
  
  
  private
  
    def chef_params
      params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
    end
  
end