require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "mashrur", email: "mashrur@example.com",
                         password: "12345678", password_confirmation: "12345678")
  end
  
  test "invalid chef update is rejected" do
    sign_in_as(@chef, "12345678")
    get edit_chef_path(@chef.id) 
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: " ", email: " " } }
    assert_template 'chefs/edit'
    assert_select 'div.card-header'
    assert_select 'p.card-text'
  end
  
  test "valid chef edit is successful" do
    sign_in_as(@chef, "12345678")
    get edit_chef_path(@chef.id) 
    assert_template 'chefs/edit'
    updated_name = "new chef name"
    updated_email = "new@example.com"
    patch chef_path(@chef), params: { chef: { chefname: updated_name, email: updated_email } }
    assert_redirected_to chef_path(@chef.id)
    assert_not flash.empty?
    @chef.reload
    assert_match updated_name, @chef.chefname
    assert_match updated_email, @chef.email
  end
  
end
