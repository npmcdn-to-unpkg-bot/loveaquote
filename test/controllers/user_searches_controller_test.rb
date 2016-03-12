require 'test_helper'

class UserSearchesControllerTest < ActionController::TestCase
  setup do
    @user_search = user_searches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_searches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_search" do
    assert_difference('UserSearch.count') do
      post :create, user_search: { source_id: @user_search.source_id, text: @user_search.text }
    end

    assert_redirected_to user_search_path(assigns(:user_search))
  end

  test "should show user_search" do
    get :show, id: @user_search
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_search
    assert_response :success
  end

  test "should update user_search" do
    patch :update, id: @user_search, user_search: { source_id: @user_search.source_id, text: @user_search.text }
    assert_redirected_to user_search_path(assigns(:user_search))
  end

  test "should destroy user_search" do
    assert_difference('UserSearch.count', -1) do
      delete :destroy, id: @user_search
    end

    assert_redirected_to user_searches_path
  end
end
