

$(document).ready(function() {

	$(".quantity").each((index, ele) => {
		
		calculateTotalQuantityAndPrice()
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
	
	$(".quantity").each((index, ele) => {
		$(ele).on("input", (e) => {
			calculateTotalQuantityAndPrice()
		});
	});
	
	
	$("#saved-address-btn").on('click',()=>{
		const newAddress = $("#new-deleivery-address").val();
		if(newAddress!="")
		{
			$("#delivery-address").html(`<div><p>${newAddress}</p> <button id="address-change-btn">Change</button> </div>`);
			$("#new-deleivery-address").val('')
			$('#add-address-form').hide();
			
			$('#address-change-btn').on('click',()=>{
		$('#add-address-form').show();
	})
		}
	})
	
	
	
})

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

function calculateTotalQuantityAndPrice()
{
	let totalQuantity = 0;
    let totalPrice = 0;
    
    $(".quantity").each((index, ele) => {
		
		totalQuantity += parseInt($(ele).val())
		totalPrice += parseInt($(ele).val()) * parseInt($(ele).data("price"))
	});
	
	
	$("#totalQuantity").text(totalQuantity)
	$("#totalAmount").html('<i class="fa-solid fa-indian-rupee-sign"></i>'+totalPrice)
}


