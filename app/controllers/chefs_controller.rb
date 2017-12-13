class ChefsController < ApplicationController
  
  def new
    @chef = Chef.new
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
  end
  
  private
  
    def chef_params
      params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
    end
  
end