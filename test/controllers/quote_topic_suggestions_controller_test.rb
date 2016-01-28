require 'test_helper'

class QuoteTopicSuggestionsControllerTest < ActionController::TestCase
  setup do
    @quote_topic_suggestion = quote_topic_suggestions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quote_topic_suggestions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quote_topic_suggestion" do
    assert_difference('QuoteTopicSuggestion.count') do
      post :create, quote_topic_suggestion: {  }
    end

    assert_redirected_to quote_topic_suggestion_path(assigns(:quote_topic_suggestion))
  end

  test "should show quote_topic_suggestion" do
    get :show, id: @quote_topic_suggestion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quote_topic_suggestion
    assert_response :success
  end

  test "should update quote_topic_suggestion" do
    patch :update, id: @quote_topic_suggestion, quote_topic_suggestion: {  }
    assert_redirected_to quote_topic_suggestion_path(assigns(:quote_topic_suggestion))
  end

  test "should destroy quote_topic_suggestion" do
    assert_difference('QuoteTopicSuggestion.count', -1) do
      delete :destroy, id: @quote_topic_suggestion
    end

    assert_redirected_to quote_topic_suggestions_path
  end
end
