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
				$body = $("#modalMessage .modal-body")
				# If errors
				if (data.errors)
					# Error messages block
					if ($body.find('.success').length > 0)
						$body.find('.success').remove()

					if ($body.find('.errors').length == 0)
						$body.prepend('<div class="errors"><ul></ul></div>')
					else
						$body.find('.errors ul').empty()

					# Error messages list
					$.each data.errors, (field, field_errors) ->
						$(".errors ul").append("<li>"+field+" : "+field_errors.join(', ')+"</li>")
				# If success
				else if (data.success)
					# Success messages block
					if ($body.find('.errors').length > 0)
						$body.find('.errors').remove()

					if ($body.find('.success').length == 0)
						$body.prepend('<div class="success"><ul></ul></div>')
					else
						$body.find('.success ul').empty()

					$(".success ul").append("<li>"+data.success+"</li>")

					setTimeout (->
						$(".success").fadeOut()
						$("#modalMessage").modal('hide')
						),1000

					$carousel = $("#carousel")
					$carousel.find(".carousel-inner, .carousel-indicators").empty()
					$carousel_inner = $carousel.find(".carousel-inner")
					$carousel_indicators = $carousel.find(".carousel-indicators")
					picture_url = "https://dummyimage.com/800x400/eee/&text="
					$.each JSON.parse(data.messages), (ind, message) ->
						console.log(ind)
						# Carousel INDICATORS
						if (ind == 0)
							$carousel_indicators.append('<li data-target="#carousel" data-slide-to="'+ind+'" class="active"></li>')
						else
							$carousel_indicators.append('<li data-target="#carousel" data-slide-to="'+ind+'" class=""></li>')

						# Carousel INNER
						if (ind == 0)
							$carousel_inner.append('<div class="item active"></div>')
						else
							$carousel_inner.append('<div class="item"></div>')

						url = picture_url+message['title']
						$carousel_inner.find('div.item:last').append('<img alt="'+message['title']+'" data-src="'+url+'" src="'+url+'" data-holder-rendered="true">')
						$carousel_inner.find('div.item:last').append('<div class="carousel-caption"><p>'+message['content']+'</p></div>')

					$form.find("input[type=text]").val("");



			    	