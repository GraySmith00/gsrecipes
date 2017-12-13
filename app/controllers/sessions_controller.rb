class SessionsController < ApplicationController
  
  def new
    
  end
  
  def create
    chef = Chef.find_by(email: params[:session][:email].downcase)
    if chef && chef.authenticate(params[:session][:password])
      session[:chef_id] = chef.id
      flash[:success] = "Welcome back #{chef.chefname}, you are now logged in."
      redirect_to chef_path(chef)
    else
      flash.now[:danger] = "An error has occured."
      render 'new'
    end
  end
  
  def destroy
    session[:chef_id] = nil
    flash[:success] = "You are now logged out."
    redirect_to login_path
  end
  
end