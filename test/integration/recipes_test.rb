require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "mashrur", email: "mashrur@example.com")
    @recipe = Recipe.create(name: "Rice and Peppers", description: "great vegetable sautee, add vegetable and oil", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Grilled Chicken", description: "delicious spicy grilled chicken!")
    @recipe2.save
  end
  
  test "should get recipes index page" do
    get recipes_path
    assert_response :success
  end
  
  test "should get recipes listing" do
  get recipes_path
  assert_template 'recipes/index'
  assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
  assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
end
  
  test "should get recipes show page" do
    get recipe_path(@recipe.id)
    assert_template 'recipes/show'
    assert_match @recipe.name.capitalize, response.body
    assert_match @recipe.description, response.body
    assert_match @recipe.chef.chefname, response.body
  end
  
end
