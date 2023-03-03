class Car < ApplicationRecord
	validates :name, :price, :brand, presence: true
	validates :name, uniqueness: true
end