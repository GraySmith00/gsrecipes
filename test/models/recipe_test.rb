require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create!(chefname: "Bob", email: "bob@example.com",
                         password: "12345678", password_confirmation: "12345678")
    @recipe = @chef.recipes.build(name: "veggie dish", description: "this is a great veggie recipe")
  end
  
  test "recipe without chef should be invalid" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  test "recipe should be valid" do
    assert @recipe.valid?
  end

  test "name should be present" do
    @recipe.name = ""
    assert_not @recipe.valid?
  end
  
  test "description should be present" do
    @recipe.description = ""
    assert_not @recipe.valid?
  end
  
  test "name should be more than 1 character" do
    @recipe.name = "a"
    assert_not @recipe.valid?
  end
  
  test "name should be less than 31 characters" do
    @recipe.name = "a" * 31
    assert_not @recipe.valid?
  end
  
  test "description shouldn't be less than 5 characters" do
    @recipe.description = "a" * 3
    assert_not @recipe.valid?
  end
  
  test "description should't be more than 501 characters" do
    @recipe.description = "a" * 2501
    assert_not @recipe.valid?
  end
  
end