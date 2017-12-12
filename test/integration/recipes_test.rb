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
    assert_select 'a[href=?]', edit_recipe_path(@recipe.id), text: "Edit"
    assert_select 'a[href=?]', recipe_path(@recipe.id), text: "Delete"
  end
  
  test "create new valid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = "chicken sautee"
    description_of_recipe = "add chicken, veggies, and cook for 20 minutes"
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: { recipe: { name: name_of_recipe, description: description_of_recipe } }
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end
  
  test "reject invalid recipe submission" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference "Recipe.count" do
      post recipes_path, params: { recipe: { name: " ", description: " " } }
    end
    assert_template 'recipes/new'
    assert_select 'div.card-header'
    assert_select 'p.card-text'
  end
  
end
