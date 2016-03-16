class Message < ActiveRecord::Base
    validates :name, presence: true
    validates :email, presence: true
    validates :subject, presence: true
    validates :content, presence: true
    
    scope :unread, -> {where(read: false)}
end
