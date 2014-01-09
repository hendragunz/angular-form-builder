require 'test_helper'

class Admin::EvaluationFormsControllerTest < ActionController::TestCase
  setup do
    @admin_evaluation_form = admin_evaluation_forms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_evaluation_forms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_evaluation_form" do
    assert_difference('Admin::EvaluationForm.count') do
      post :create, admin_evaluation_form: {  }
    end

    assert_redirected_to admin_evaluation_form_path(assigns(:admin_evaluation_form))
  end

  test "should show admin_evaluation_form" do
    get :show, id: @admin_evaluation_form
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_evaluation_form
    assert_response :success
  end

  test "should update admin_evaluation_form" do
    patch :update, id: @admin_evaluation_form, admin_evaluation_form: {  }
    assert_redirected_to admin_evaluation_form_path(assigns(:admin_evaluation_form))
  end

  test "should destroy admin_evaluation_form" do
    assert_difference('Admin::EvaluationForm.count', -1) do
      delete :destroy, id: @admin_evaluation_form
    end

    assert_redirected_to admin_evaluation_forms_path
  end
end
