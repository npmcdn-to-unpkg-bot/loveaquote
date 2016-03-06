class SeasonAndEpisode < ActiveRecord::Base
    belongs_to :quote, inverse_of: :season_and_episode
    validates :quote, presence: true, uniqueness: true, blank: false
end
