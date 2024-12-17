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


function handleBuyClick(url)
{
	
	window.location.href= url;
}



