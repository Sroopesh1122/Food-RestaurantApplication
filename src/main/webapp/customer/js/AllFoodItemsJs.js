$(document).ready(function() {

	let searchData = [];
	let suggestionPointer = 0;
	$("#search-input").on('keydown', function(e) {
		if (e.key === "Enter") {
			if (searchData.length != 0) {
				e.preventDefault();
				const selectedSuggestion = $("#suggestion span")[suggestionPointer]
				const searchText = $(selectedSuggestion).text()
				$("#search-input").val(searchText);
				$("#search-form").submit()
			}

		}
		
		

		else {

			if (searchData.length > 0) {
				if (e.key === "ArrowUp") {
					if (suggestionPointer == 0) {
						suggestionPointer = searchData.length - 1
					}
					else {
						suggestionPointer--;
					}
				}
				else if (e.key === "ArrowDown") {
					if (suggestionPointer >= searchData.length - 1) {
						suggestionPointer = 0
					}
					else {
						suggestionPointer++;
					}
				}
			} else {
				suggestionPointer = 0;
			}
			handleSuggestionNavigation(suggestionPointer)

		}

	})

	function handleSuggestionNavigation(index) {
		const suggestions = $("#suggestion span");

		suggestions.each((idx, ele) => {
			if (idx === index) {
				$(ele).addClass("suggestion-active")
			} else {
				$(ele).removeClass("suggestion-active")
			}
		});
	}
	$("#search-input").on("input", function() {
		const inputValue = $(this).val();
		const jsonData = { text: inputValue };
		if (inputValue != "") {
			fetch("http://localhost:8080/OnlineFoodRestaurant/suggestion/food", {
				method: "POST",
				headers: {
					"Content-Type": "application/json",
				},
				body: JSON.stringify(jsonData),
			})
				.then((res) => {
					if (!res.ok) {
						throw new Error("Network response was not ok " + res.statusText);
					}
					return res.json();
				})
				.then((data) => {
					if (data.length > 0) {
						searchData = data;
						suggestionPointer = 0;
						$("#suggestion").addClass("suggestion-results")
						$("#suggestion").removeClass("suggestion-not-found")
						$("#suggestion").show();
						$('#suggestion').html('')

						data.forEach((d) => {
							$('#suggestion').append(`<span onclick="handleSuggestionClick('${d}')" >${d}</span>`);

						})
						const firstSuggestion = $("#suggestion span")[0]
						$(firstSuggestion).addClass("suggestion-active")
					} else {
						$("#suggestion").show();
						$("#suggestion").removeClass("suggestion-results")
						$("#suggestion").addClass("suggestion-not-found")
						$('#suggestion').html('<span>No Data Found</span>')
					}
					console.log("Suggestions:", data);
				})
				.catch((error) => {
					console.error("Fetch error:", error);
				});
		} else {
			$("#suggestion").hide();
			$("#suggestion").removeClass("suggestion-results")
			$("#suggestion").removeClass("suggestion-not-found")
			$('#suggestion').html('<span>Search here</span>')
		}
	});
});

function handleSuggestionClick(value) {
	$("#search-input").val(value);
	$("#suggestion").hide();
	$("#suggestion").removeClass("suggestion-results")
	$("#suggestion").removeClass("suggestion-not-found")
	$('#suggestion').html('')

}

function handleCardClick(url) {
	window.location.href= url
}

function handleCartBtnClick(userId, foodId, loginUrl, cartUrl) {
	event.stopPropagation();
	const button = $(event.target);
	if (-1 === parseInt(userId)) {
		showNotificationPromise('Warning', 'warning', 'Please Login')
			.then((confirmed) => {
				window.location.href = loginUrl
			});
		//window.location.href = loginUrl
	} else {

		const jsonData = {
			"userId": userId,
			"foodId": foodId
		}
		fetch("http://localhost:8080" + cartUrl, {
			method: "POST",
			headers: {
				"Content-Type": "application/json",
			},
			body: JSON.stringify(jsonData),
		})
			.then((res) => {
				if (!res.ok) {
					throw new Error("Network response was not ok " + res.statusText);
				}
				return res.json();
			})
			.then((data) => {

				if (data.error) {
					showNotificationPromise('Warning', 'warning', 'Please Login')
						.then((confirmed) => {
							window.location.href = loginUrl
						});
				} else if (data.failed) {
					showNotification('Error', 'error', 'Failed To add')
				} else {
					Swal.fire({
						position: "top-end",
						icon: "success",
						title: "Itam added to cart",
						showConfirmButton: false,
						timer: 1000
					});
					 // jQuery object for the clicked button
	                button.html('<i class="fa-solid fa-cart-shopping"></i> Saved')
	                button.removeAttr('onclick');
	                button.attr("onclick", 'handlePreventDefault(event)');
				}

			})
			.catch((error) => {
				console.error("Fetch error:", error);
			});
	}
}

function handlePreventDefault(event)
{
	event.stopPropagation()
}

function handleBuyClick(url)
{
	
	window.location.href= url;
}



