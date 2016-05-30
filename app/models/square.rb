class Square < ApplicationRecord
	belongs_to :project
	before_save :update_adjacent, if: :used_changed?
	
	def is_center?
		position == 44 ? true : false
	end
			
	def top_adjacent
		return nil if position > 89
		Square.where(project_id: project_id, position: position + 10).first
	end
	
	def bottom_adjacent
		return nil if position < 9
		Square.where(project_id: project_id, position: position - 10).first
	end
	
	def left_adjacent
		return nil if position.divmod(10)[1] == 0
		Square.where(project_id: project_id, position: position - 1).first
	end
	
	def right_adjacent
		return nil if position.divmod(10)[1] == 9
		Square.where(project_id: project_id, position: position + 1).first
	end
	
	def update_adjacent
		[top_adjacent, bottom_adjacent, left_adjacent, right_adjacent].each do |square|
			next unless square
			square.usable = true
			square.save!
		end
	end
	
	def self.is_usable? (sq)
		return false if sq.used
		return true if top_adjacent.used || bottom_adjacent.used || left_adjacent.used || right_adjacent.used
		false
	end
end
