require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "mashrur", email: "mashrur@example.com",
                         password: "12345678", password_confirmation: "12345678")
    @recipe = Recipe.create(name: "Rice and Peppers", 
                            description: "great vegetable sautee, add vegetable and oil", 
                            chef: @chef)
  end
  
  test "invalid recipe update is rejected" do
    get edit_recipe_path(@recipe.id)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: { name: " ", description: "some description" } }
    assert_template 'recipes/edit'
    assert_select 'div.card-header'
    assert_select 'p.card-text'
  end
  
  test "succesfully edit a recipe" do
    get edit_recipe_path(@recipe.id)
    assert_template 'recipes/edit'
    updated_name = "updated recipe name"
    updated_description = "updated recipe description"
    patch recipe_path(@recipe), params: { recipe: { name: updated_name, description: updated_description }}
    assert_redirected_to recipe_path(@recipe.id)
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name, @recipe.name
    assert_match updated_description, @recipe.description
  end
  
  
  
  
  
  
  
  
  
  
end
