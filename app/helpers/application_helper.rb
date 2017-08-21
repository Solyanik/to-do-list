module ApplicationHelper
	def project_flag(flag)
		"<i class=\"d-inline-block project-flag\" style=\"background: #{ flag };\"></i>".html_safe
	end

	def task_priority(priority)
		{
			'1': "<i class=\"d-inline-block priority-tall\"></i>",
			'2': "<i class=\"d-inline-block priority-average\"></i>",
			'3': "<i class=\"d-inline-block priority-low\"></i>",
		}[priority.to_i.to_s.to_sym].html_safe
	end

	def bootstrap_class_for(name)
	    { 
	    	success:"alert-success",
	      	error:  "alert-danger",
	      	danger: "alert-danger",
	      	alert:  "alert-warning",
	      	notice: "alert-info"
	    }[name.to_sym] || name
	end
end
