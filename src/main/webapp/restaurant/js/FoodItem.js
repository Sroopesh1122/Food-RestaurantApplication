$(document).ready(function(){
	
	let priceError= false;
	
	function chekPrice()
	{
		const errorSpan = $("#price").siblings("span")
		if($("#price").val() === "")
		{
			$(errorSpan).text("Required");
			$(errorSpan).removeClass("hidden");
			priceError=true;
		}else if($("#price").val()===0){
			$(errorSpan).text("Price Cannot be zero");
			$(errorSpan).removeClass("hidden")
			priceError=true
		}else{
			$(errorSpan).text("");
			$(errorSpan).addClass("hidden")
			priceError=false
		}
		
		console.log(errorSpan)
	}
	
	$("#price").on('input',()=>{
		chekPrice();
	})
	
	
	
	$("#update-btn").on('click',()=>{
		
		if(!priceError)
		{
			$("#update-form").submit()
		}
		
	})
})