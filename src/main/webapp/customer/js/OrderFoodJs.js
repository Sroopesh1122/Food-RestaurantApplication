function handleQuantityIncrease(ele) {
	const inputElement = $('#' + ele);
	const prevVal = parseInt(inputElement.val(), 10) || 1;

	inputElement.val(prevVal + 1);
	calculateTotalQuantityAndPrice()
}

function handleQuantityDecrease(ele) {

	const inputElement = $('#' + ele);
	const prevVal = parseInt(inputElement.val(), 10) || 1;

	if (prevVal > 1) {
		inputElement.val(prevVal - 1);
		calculateTotalQuantityAndPrice()
	}
}

$(document).ready(function(){
	
	$(".quantity").each((index, ele) => {
		$(ele).on("keydown", (e) => {
			const allowedKeys = [
				"Backspace",
				"Delete",
			];
			if (
				!(e.key >= "0" && e.key <= "9") &&
				!allowedKeys.includes(e.key)
			) {
				e.preventDefault();
			}
		});
	});
})

function handleSubmit()
{
	let addressError = false;
	let quantityError=false;
	$("#address")
	if($("#address").val() === "Enter Delivery Address" || $("#address").val() === "")
	{
		$("#address-error").removeClass("hidden");
		addressError=true
	}else{
		
		$("#address-error").addClass("hidden");
		addressError=false
	}
	const quantity = parseInt($("#quantity").val());
	
	if(quantity <=0)
	{
		quantityError=true;
		$("#quantity-error").removeClass("hidden")
	}else{
		quantityError=false;
		$("#quantity-error").addClass("hidden")
	}
	
	alert(addressError +" "+quantityError)
	
	if(!addressError && !quantityError)
	{
		$("#order-form").submit();
	}
	
}