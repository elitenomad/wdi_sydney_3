class Song < ActiveRecord::Base
	belongs_to :artist
	belongs_to :album

	validates :name,:artist_id, presence: true

	self.per_page = 10
end
