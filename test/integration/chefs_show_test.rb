require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest

    def setup
      @chef = Chef.create!(chefname: "mashrur", email: "mashrur@example.com",
                           password: "12345678", password_confirmation: "12345678")
      @recipe = Recipe.create(name: "Rice and peppers", description: "great vegetable sautee, add vegetable and oil", chef: @chef)
      @recipe2 = @chef.recipes.build(name: "Grilled chicken", description: "delicious spicy grilled chicken!")
      @recipe2.save
    end
    
    test "should get chef show page" do
      get chef_path(@chef.id)
      assert_template 'chefs/show'
      assert_select "a[href=?]", recipe_path(@recipe.id), text: @recipe.name
      assert_select "a[href=?]", recipe_path(@recipe2.id), text: @recipe2.name
      assert_match @recipe.description, response.body
      assert_match @recipe2.description, response.body
      assert_match @chef.chefname, response.body
    end

end
