class Shelter < ActiveRecord::Base
	has_many :pets, dependent: :destroy

	validates :name, presence: true 
	validates :name, uniqueness: true

	validates :location, presence: true
	validates :tot_capacity, presence: true
end