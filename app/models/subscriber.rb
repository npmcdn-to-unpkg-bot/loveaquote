class Subscriber < ActiveRecord::Base
    scope :unread, -> {where(read: false)}
end
