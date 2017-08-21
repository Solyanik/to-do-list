angular.module('app', []).controller 'main', ['$scope', '$http', ($scope, $http) ->

	$scope.task = []
	$scope.project = []
	$scope.form_task = false
	$scope.form_project = false
	id_form_name = "#form-task"
	$('#form-project, #form-task').removeClass('ng-hide')

	# Projects
	$scope.open_add_project = () ->
		$scope.successMessageProject = false
		$scope.errorMessagesProject = false
		$scope.project = []
		$scope.form_project = true

		$('#form-project input[name="project[flag]"]').colorpicker().on 'changeColor', (ev) ->
			$('#form-project input[name="project[flag]"]').attr('style', 'background: ' + ev.color.toHex() + ';')
			return
		
	$scope.open_edit_project = (id) ->
		$scope.successMessageProject = false
		$scope.errorMessagesProject = false

		$('#form-project input[name="project[flag]"]').colorpicker().on 'changeColor', (ev) ->
			$('#form-project input[name="project[flag]"]').attr('style', 'background: ' + ev.color.toHex() + ';')
			return

		$http(method: 'GET', url: '/projects/' + id + '.json').then ((response) ->
				$scope.project = response.data

				$('#form-project input[name="project[flag]"]').attr('style', 'background: ' + $scope.project.flag + ';')
				$scope.form_project = true
				return

		), (response) ->
			return

	$scope.submit_project = () ->
		if $('#form-project input[name="project[flag]"]').val()
			flag = $('#form-project input[name="project[flag]"]').val()
		else
			flag = $('#form-project input[name="project[flag]"]').attr("default-value")

		data = {
			project: {
				name: $('#form-project input[name="project[name]"]').val(),
				user_id: $('#form-project input[name="project[user]"]').val(),
				flag: flag
			}
		}

		method = "Post"

		if $scope.project.id
			data.project.id = $scope.project.id
			data = data.project
			method = "PUT"

		config = {
			headers : {
				'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8;'
			}
		}

		$http({
			method: method, 
			url: '/projects.json', 
			data: data, 
			config: config
			}).then ((response) ->
				
				$scope.successMessageProject = response.statusText + ': ' + response.data.name
				$scope.errorMessagesProject = false

				return
		), (response) ->
			$scope.successMessageProject = false
			$scope.errorMessagesProject = response.data

			return

	# Tasks
	$scope.open_add_task = () ->
		$scope.successMessageTask = false
		$scope.errorMessagesTask = false
		$scope.task = []
		$scope.form_task = true

		$('html, body').animate({scrollTop: $(id_form_name).offset().top}, 'slow')

	$scope.open_edit_task = (id) ->
		$scope.successMessageTask = false
		$scope.errorMessagesTask = false

		$http(method: 'GET', url: '/tasks/' + id + '.json').then ((response) ->
				$scope.task = response.data
				if $scope.task.deadline
					deadline = $scope.task.deadline.split('-')
					$scope.task.deadline = deadline[1] + '/' + deadline[2].split('T')[0] + '/' + deadline[0]
				$scope.form_task = true
				return

		), (response) ->
			return

		$('html, body').animate({scrollTop: $(id_form_name).offset().top}, 'slow')

	$scope.submit_task = () ->
		deadline = $('#form-task input[name="task[deadline]"]').val().split('/')

		data = {
			task: {
				name: $('#form-task input[name="task[name]"]').val(),
				deadline: deadline[2] + '-' + deadline[0] + '-' + deadline[1],
				project_id: $('#form-task input[name="task[project]"]:checked').val(),
				priority: $('#form-task input[name="task[priority]"]:checked').val()
			}
		}

		method = "Post"

		if $scope.task.id
			data.task.id = $scope.task.id
			data = data.task
			method = "PUT"

		config = {
			headers : {
				'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8;'
			}
		}

		$http({
			method: method, 
			url: '/tasks.json', 
			data: data, 
			config: config
			}).then ((response) ->
				
				$scope.successMessageTask = response.statusText + ': ' + response.data.name
				$scope.errorMessagesTask = false

				$('html, body').animate({scrollTop: $(id_form_name).offset().top}, 'slow')

				return
		), (response) ->
			$scope.successMessageTask = false
			$scope.errorMessagesTask = response.data
			$('html, body').animate({scrollTop: $(id_form_name).offset().top}, 'slow')
			return

]