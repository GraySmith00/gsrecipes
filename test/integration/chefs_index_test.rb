require 'test_helper'

class ChefsIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "mashrur", email: "mashrur@example.com",
                         password: "12345678", password_confirmation: "12345678")
    
     @chef2 = Chef.create!(chefname: "bob", email: "bob@example.com",
                         password: "12345678", password_confirmation: "12345678")                     
  end
  
  test "should get chefs index page" do
    get chefs_path
    assert_response :success
  end
  
  test "should get chefs listing" do
    get chefs_path
    assert_template "chefs/index"
    assert_select "a[href=?]", chef_path(@chef.id), text: @chef.chefname
  end
  
  
  
end
