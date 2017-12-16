class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.build(comment_params)
    @comment.chef = current_chef
    
    if @comment.save
      flash[:success] = "Comment has been added."
      redirect_to recipe_path(@recipe)
    else
      flash[:danger] = "Your comment was not added."
      redirect_to :back
    end
  end
  
  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment has been removed."
    redirect_to recipe_path(@recipe)
  end
  
  private
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  
  
  
  
  
end