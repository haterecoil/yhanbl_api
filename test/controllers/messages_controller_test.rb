require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  setup do
    @message = messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:messages)
  end

  test "should create message" do
    assert_difference('Message.count') do
      post :create, message: { answered_on: @message.answered_on, read_on: @message.read_on, sent_on: @message.sent_on, text: @message.text, title: @message.title }
    end

    assert_response 201
  end

  test "should show message" do
    get :show, id: @message
    assert_response :success
  end

  test "should update message" do
    put :update, id: @message, message: { answered_on: @message.answered_on, read_on: @message.read_on, sent_on: @message.sent_on, text: @message.text, title: @message.title }
    assert_response 204
  end

  test "should destroy message" do
    assert_difference('Message.count', -1) do
      delete :destroy, id: @message
    end

    assert_response 204
  end
end
