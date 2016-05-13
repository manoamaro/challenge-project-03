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

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create message" do
    assert_difference('Message.count') do
      post :create, message: {content: @message.content, title: @message.title }
    end

    assert_redirected_to messages_path
  end

  test "should read message" do
    assert @message.reload.unread?
    get :show, id: @message
    assert @message.reload.read?
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @message
    assert_response :success
  end

  test "should update message" do
    patch :update, id: @message, message: { content: @message.content, title: @message.title }
    assert_redirected_to message_path(assigns(:message))
  end

  test "should archive message" do
    patch :archive, id: @message

    assert @message.reload.archived?

    assert_redirected_to messages_path
  end

  test "should archive all messages" do
    post :archive_all

    assert_equal 2, Message.where(state: 'archived').count

    assert_redirected_to messages_path
  end

end
