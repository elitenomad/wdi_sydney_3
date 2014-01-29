class Album < ActiveRecord::Base
	has_many :songs
	belongs_to :artist

	validates :name, presence: true
end
