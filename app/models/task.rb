class Task < ActiveRecord::Base

	validates :name, :priority, :project, presence: true
	validates_numericality_of :priority, :in => 1..3
  	
  	default_scope { order(deadline_expired: :desc, priority: :asc) }

  	belongs_to :project

  	def to_s
		"#{name}"
	end

end