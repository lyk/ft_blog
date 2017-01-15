# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
	$('#save').click (e) ->
		e.preventDefault();
		$form = $("#formMessage")
		$.ajax $form.attr("action"),
			type: $form.attr('method')
			data: $form.serialize()
			error: (jqXHR, textStatus, res) ->
			success: (data, textStatus, jqXHR) ->
				if(data.errors)
					$body = $("#modalMessage .modal-body")
					if ($body.find('.errors').length == 0)
						$body.prepend('<div class="errors"><ul></ul></div>')
					else
						$body.find('.errors ul').empty()
					$.each data.errors, (field, field_errors) ->
						$(".errors ul").append("<li>"+field+" : "+field_errors.join(', ')+"</li>")
