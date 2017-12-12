require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "mashrur", email: "mashrur@example.com")
    @recipe = Recipe.create(name: "Rice and Peppers", 
                            description: "great vegetable sautee, add vegetable and oil", 
                            chef: @chef)
  end
  
  test "succesfully delete a recipe" do
    get recipe_path(@recipe.id)
    assert_template 'recipes/show'
    assert_select 'a[href=?]', recipe_path(@recipe.id), text: "Delete"
    assert_difference "Recipe.count", -1 do
      delete recipe_path(@recipe.id)
    end
    assert_redirected_to recipes_path
    assert_not flash.empty?
  end
  
end
