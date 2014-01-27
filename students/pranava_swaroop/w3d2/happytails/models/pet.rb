class Pet < ActiveRecord::Base
	belongs_to :shelter


	validates :name,  presence: true
	validates :spieces,  presence: true
	validates :breed,  presence: true
	validates :age,  presence: true

end