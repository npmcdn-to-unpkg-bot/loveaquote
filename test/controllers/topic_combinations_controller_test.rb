require 'test_helper'

class TopicCombinationsControllerTest < ActionController::TestCase
  setup do
    @topic_combination = topic_combinations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:topic_combinations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topic_combination" do
    assert_difference('TopicCombination.count') do
      post :create, topic_combination: { primary_topic_id: @topic_combination.primary_topic_id, secondary_topic_id: @topic_combination.secondary_topic_id, slug: @topic_combination.slug }
    end

    assert_redirected_to topic_combination_path(assigns(:topic_combination))
  end

  test "should show topic_combination" do
    get :show, id: @topic_combination
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @topic_combination
    assert_response :success
  end

  test "should update topic_combination" do
    patch :update, id: @topic_combination, topic_combination: { primary_topic_id: @topic_combination.primary_topic_id, secondary_topic_id: @topic_combination.secondary_topic_id, slug: @topic_combination.slug }
    assert_redirected_to topic_combination_path(assigns(:topic_combination))
  end

  test "should destroy topic_combination" do
    assert_difference('TopicCombination.count', -1) do
      delete :destroy, id: @topic_combination
    end

    assert_redirected_to topic_combinations_path
  end
end
