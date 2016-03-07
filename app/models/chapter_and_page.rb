class ChapterAndPage < ActiveRecord::Base
    belongs_to :quote, inverse_of: :chapter_and_page
    validates :quote, presence: true, uniqueness: true, blank: false
end
