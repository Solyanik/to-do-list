json.extract! task, :id, :name, :priority, :project_id, :deadline
json.url task_url(task, format: :json)
