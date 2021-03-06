class Project < ApplicationRecord
	has_many :squares, dependent: :destroy
	has_many :users, through: :subscriptions
	has_many :subscriptions
	
	after_create :build_squares
	
	def build_squares
		position = 0
		100.times do
			sq = squares.create!(
				title: "",
				position: position,
				usable: position == 44  )
			position += 1
		end
	end
end
