class Subscriber < ActiveRecord::Base
    validates :email, presence: true, uniqueness: true, blank: false
    scope :unread, -> {where(read: false)}
    scope :verified, -> {where(verified: true)}
end
