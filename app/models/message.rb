class Message < ActiveRecord::Base

  validates :title, :content, presence: true

  state_machine :state, initial: :unread do

    event :read do
      transition unread: :read 
    end

    event :archive do
      transition any => :archived
    end

    after_transition to: :read do |message|
      message.read_at = Time.current
      message.save
    end

    after_transition to: :archived do |message|
      message.archived_at = Time.current
      message.save
    end

  end

  def self.archive_all!
    Message.where.not(state: 'archived').find_each(&:archive)
  end

end
