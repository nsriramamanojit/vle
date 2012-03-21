require 'test_helper'

class PanchayatsControllerTest < ActionController::TestCase
  setup do
    @panchayat = panchayats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:panchayats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create panchayat" do
    assert_difference('Panchayat.count') do
      post :create, :panchayat => @panchayat.attributes
    end

    assert_redirected_to panchayat_path(assigns(:panchayat))
  end

  test "should show panchayat" do
    get :show, :id => @panchayat.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @panchayat.to_param
    assert_response :success
  end

  test "should update panchayat" do
    put :update, :id => @panchayat.to_param, :panchayat => @panchayat.attributes
    assert_redirected_to panchayat_path(assigns(:panchayat))
  end

  test "should destroy panchayat" do
    assert_difference('Panchayat.count', -1) do
      delete :destroy, :id => @panchayat.to_param
    end

    assert_redirected_to panchayats_path
  end
end
