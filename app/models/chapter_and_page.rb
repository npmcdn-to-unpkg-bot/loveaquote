class ChapterAndPage < ActiveRecord::Base
    belongs_to :quote
    validates :quote_id, presence: true, uniqueness: true, blank: false
end
