let check = false;

$(document).ready(function() {
	let emailError=false;
	let passwordError = false;

	for (let i = 0; i < $(".error").length; i++) {
		const ele = $(".error")[i];
		$(ele).hide()
	}


	function checkEmail() {
		if ($("#email").val().trim() === "" || !$("#email").val().includes("@")) {
			const ele = $("#email").siblings(".error")[0];
			$(ele).show();
			$("#email").addClass("input-error");
			emailError = true;
		} else {
			const ele = $("#email").siblings(".error")[0];
			$(ele).hide()
			$("#email").removeClass("input-error")
			emailError = false
		}
	}

	function checkPassword() {
     if ($("#password").val().trim() === "") {
			const ele = $("#password").siblings(".error")[0];
			$(ele).text("Please enter password")
			$(ele).show();
			$("#password").addClass("input-error")
			passwordError= true;
		} else {
				const ele = $("#password").siblings(".error")[0];
				$(ele).hide()
				$("#password").removeClass("input-error")
				passwordError= false;
		}


	}

	$("#email").on('input', function() {
		if (check) {
			checkEmail()
		}
	})

	$("#password").on('input', function() {
		if (check) {
			checkPassword()
		}
	})

    $("#login-btn").on('click',function(){
		check = true;
		checkEmail();
		checkPassword();
		
		if(!emailError && !passwordError)
		{
			$("#signinForm").submit()
		}
		
	})
})
