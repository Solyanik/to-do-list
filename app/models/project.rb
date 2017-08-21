class Project < ActiveRecord::Base

	validates :name, :flag, :user, presence: true
	has_many :task
	belongs_to :user

	def quantity
		Task.where(project_id: id, status: false).size.to_i
	end

	def tasks
		Task.where(project_id: id, status: false)
	end

	def to_s
		"#{name}"
	end
end