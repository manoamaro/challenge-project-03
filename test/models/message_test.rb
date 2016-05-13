require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  #
  # Validations
  #

  test "title presence" do
    message = Message.new
    assert message.invalid?
    assert message.errors[:title].present?
  end

  test "content presence" do
    message = Message.new
    assert message.invalid?
    assert message.errors[:content].present?
  end

  #
  # State machine
  # 
  test "initial state" do
    message = Message.create(title: '1', content: '2')
    assert message.unread?
  end

  test "reading a message" do
    message = messages(:one)

    assert message.unread?
    message.read

    assert message.read?
    assert message.read_at.present?
  end

  test "archiving a message" do
    message = messages(:one)

    assert !message.archived?
    message.archive

    assert message.archived?
  end

  test "archiving all messages" do

    Message.find_each {|message| assert !message.archived?}

    Message.archive_all!

    assert_equal 2, Message.where(state: 'archived').count
  end

end
