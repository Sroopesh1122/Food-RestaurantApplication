

$(document).ready(function() {

	let check = false;

	let nameError = false;
	let emailError = false;
	let mobileError = false;
	let addressError = false;
	let passwordError = false;
	let cpasswordError = false;


	for (let i = 0; i < $(".error").length; i++) {
		const ele = $(".error")[i];
		$(ele).hide()
	}



	function checkName() {
		if ($("#name").val().trim() === "") {
			const ele = $("#name").siblings(".error")[0];
			$(ele).text("Please Enter restaurant name")
			$(ele).show();
			$("#name").addClass("input-error")
			nameError = true;
		}
		else if ($("#name").val().trim().length <= 3) {
			const ele = $("#name").siblings(".error")[0];
			$(ele).text("Name must has atleast 3 characters")
			$(ele).show();
			$("#name").addClass("input-error")
			nameError = true;
		}
		else {
			const ele = $("#name").siblings(".error")[0];
			$(ele).hide()
			$("#name").removeClass("input-error")
			nameError = false;
		}
	}

	function checkEmail() {
		if ($("#email").val().trim() === "" || !$("#email").val().includes("@")) {
			const ele = $("#email").siblings(".error")[0];
			$(ele).show();
			$("#email").addClass("input-error")
			emailError = true;
		} else {
			const ele = $("#email").siblings(".error")[0];
			$(ele).hide()
			$("#email").removeClass("input-error")
			emailError = false;
		}
		console.log("Hia")
	}
	function checkMobile() {

		if ($("#mobile").val().trim() === "") {
			const ele = $("#mobile").siblings(".error")[0];
			$(ele).text("Please enter mobile no");
			$(ele).show();
			$("#mobile").addClass("input-error")
			mobileError = true;
		} else if ($("#mobile").val().trim().length <10) {
			const ele = $("#mobile").siblings(".error")[0];
			$(ele).text("Phone no must be 10 digit");
			$(ele).show();
			$("#mobile").addClass("input-error")
			mobileError = true;
		}
		else if ($("#mobile").val().trim().length === 10) {
			const ele = $("#mobile").siblings(".error")[0];
			$(ele).hide()
			$("#mobile").removeClass("input-error")
			mobileError = false;
		}
	}

	function checkAddress() {
		if ($("#address").val().trim() === "") {
			const ele = $("#address").siblings(".error")[0];
			$(ele).text("Please enter address")
			$(ele).show();
			$("#address").addClass("input-error");
			addressError = true;
		}
		else if ($("#address").val().trim().length <= 5) {
			const ele = $("#address").siblings(".error")[0];
			$(ele).text("Address must have atleast 6 characters")
			$(ele).show();
			$("#address").addClass("input-error");
			addressError = true;
		}
		else {
			const ele = $("#address").siblings(".error")[0];
			$(ele).hide()
			$("#address").removeClass("input-error");
			addressError = false;
		}
	}

	function checkPassword() {
		const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

		if ($("#password").val().trim() === "") {
			const ele = $("#password").siblings(".error")[0];
			$(ele).text("Please enter password")
			$(ele).show();
			$("#password").addClass("input-error")
			passwordError = true;
		} else {
			if (passwordPattern.test($("#password").val())) {
				const ele = $("#password").siblings(".error")[0];
				$(ele).hide()
				$("#password").removeClass("input-error")
				passwordError = false;
			} else {
				const ele = $("#password").siblings(".error")[0];
				$(ele).text("Password must have 1 uppercase,1 lowercase,1 number,and 1 special Character.")
				$(ele).show();
				$("#password").addClass("input-error");
				passwordError = true;
			}
		}


	}

	function checkCPassword() {


		if ($("#cpassword").val().trim() === "") {
			const ele = $("#cpassword").siblings(".error")[0];
			$(ele).text("Please enter confirm password");
			$(ele).removeClass("success");
			$(ele).show();
			$("#cpassword").addClass("input-error");
			cpasswordError = true;
		} else {
			if ($("#password").val() !== $("#cpassword").val()) {
				const ele = $("#cpassword").siblings(".error")[0];
				$(ele).text("Password must match");
				$(ele).removeClass("success");
				$(ele).show();
				$("#cpassword").addClass("input-error");
				cpasswordError = true;
			} else {
				const ele = $("#cpassword").siblings(".error")[0];
				$(ele).text("Password Matched");
				$(ele).addClass("success");
				$(ele).show();
				$("#cpassword").removeClass("input-error");
				cpasswordError = false;
			}
		}
	}





	$("#name").on('input', function() {
		if (check) {
			checkName();
		}
	})

	$("#email").on('input', function() {
		if (check) {
			checkEmail();
		}
	})

	$("#address").on('input', function() {
		if (check) {
			checkAddress();
		}
	})

	$("#password").on('input', function() {
		if (check) {
			checkPassword();
		}
	})

	$("#cpassword").on('input', function() {
		if (check) {
			checkCPassword();
		}
	})



	$("#mobile").keydown(function(e) {
		let phno = document.getElementById("mobile");

		if (e.key === "Backspace") {
			setTimeout(() => {
				if (check) {
					checkMobile();
				}
			}, 0);
			return;
		}

		if (!(e.key >= 0 && e.key <= 9)) {
			e.preventDefault(); // Prevent non-numeric input
		} else {
			e.preventDefault(); // Prevent default keydown behavior
			if (phno.value.length < 10) {
				phno.value += e.key; // Append the digit to the value
			}
		}
		if (check) {
			checkMobile();
		}
	});


	$("#register-btn").on('click', function() { // Check function parentheses
		check = true;


		checkName();
		checkEmail();
		checkMobile();
		checkAddress();
		checkPassword();
		checkCPassword();

		if (!nameError && !emailError && !mobileError && !addressError && !passwordError && !cpasswordError) { // Correct condition check
			//$("#register-loading").removeClass("hidden")
			$("#signupForm").submit();
		} else {
			$("#register-loading").addClass("hidden");
		}
	});
})





