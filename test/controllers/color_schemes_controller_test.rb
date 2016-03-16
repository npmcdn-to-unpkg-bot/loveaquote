require 'test_helper'

class ColorSchemesControllerTest < ActionController::TestCase
  setup do
    @color_scheme = color_schemes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:color_schemes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create color_scheme" do
    assert_difference('ColorScheme.count') do
      post :create, color_scheme: { background_color: @color_scheme.background_color, foreground_color: @color_scheme.foreground_color }
    end

    assert_redirected_to color_scheme_path(assigns(:color_scheme))
  end

  test "should show color_scheme" do
    get :show, id: @color_scheme
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @color_scheme
    assert_response :success
  end

  test "should update color_scheme" do
    patch :update, id: @color_scheme, color_scheme: { background_color: @color_scheme.background_color, foreground_color: @color_scheme.foreground_color }
    assert_redirected_to color_scheme_path(assigns(:color_scheme))
  end

  test "should destroy color_scheme" do
    assert_difference('ColorScheme.count', -1) do
      delete :destroy, id: @color_scheme
    end

    assert_redirected_to color_schemes_path
  end
end
