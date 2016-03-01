require 'test_helper'

class TvShowsControllerTest < ActionController::TestCase
  setup do
    @tv_show = tv_shows(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tv_shows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tv_show" do
    assert_difference('TvShow.count') do
      post :create, tv_show: { image: @tv_show.image, name: @tv_show.name, popular: @tv_show.popular, published: @tv_show.published, slug: @tv_show.slug, very_popular: @tv_show.very_popular }
    end

    assert_redirected_to tv_show_path(assigns(:tv_show))
  end

  test "should show tv_show" do
    get :show, id: @tv_show
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tv_show
    assert_response :success
  end

  test "should update tv_show" do
    patch :update, id: @tv_show, tv_show: { image: @tv_show.image, name: @tv_show.name, popular: @tv_show.popular, published: @tv_show.published, slug: @tv_show.slug, very_popular: @tv_show.very_popular }
    assert_redirected_to tv_show_path(assigns(:tv_show))
  end

  test "should destroy tv_show" do
    assert_difference('TvShow.count', -1) do
      delete :destroy, id: @tv_show
    end

    assert_redirected_to tv_shows_path
  end
end
