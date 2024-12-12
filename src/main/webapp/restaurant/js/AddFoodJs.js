$(document).ready(function() {

	$("#upload-btn").on('click', () => {
		$("#img-file").click()
	})


	for (let i = 0; i < $(".error").length; i++) {
		const ele = $(".error")[i];
		$(ele).hide()
	}

	$("#upload-remove").hide()
	$("#upload-remove").on('click', handleFileRemove)

	$("#img-file").on('change', handleFileChange);
	$("#name").on('input',checkName)
    $("#desc").on('input',checkDesc)
     $("#price").on('input',checkPrice)
     $("#category").on('input',checkCategory)
	$("#submit-btn").on('click', handleSubmit)

})

let error = false;
let check = false;

function checkName() {
	if (check) {
		const val = $("#name").val();
		const ele = $("#name").siblings(".error")[0];
		if (val === "") {
			$(ele).text("Required")
			$(ele).show()
			error = true;
		}
		else if (val.length <=2) {
			$(ele).text("Name must contain atleast 3 characters")
			$(ele).show()
			error = true;
		}
		else {
			$(ele).text("")
			$(ele).hide()
			error = true;
			error = false
		}
	}
}

function checkPrice() {
	if (check) {
		const val = $("#price").val();
		const ele = $("#price").siblings(".error")[0];
		if (val === "") {
			$(ele).text("Required")
			$(ele).show()
			error = true;
		}
		else if (parseInt(val) == 0) {
			$(ele).text("Price can't be zero")
			$(ele).show()
			error = true;
		}
		else {
			$(ele).text("")
			$(ele).hide()
			error = true;
			error = false
		}
	}
}

function checkDesc() {
	if (check) {
		const val = $("#desc").val();
		const ele = $("#desc").siblings(".error")[0];
		if (val === "") {
			$(ele).text("Required")
			$(ele).show()
			error = true;
		}
		else if (val.length <=10) {
			$(ele).text("Name must contain atleast min 10 and max 499 characters")
			$(ele).show()
			error = true;
		}
		else {
			$(ele).text("")
			$(ele).hide()
			error = true;
			error = false
		}
	}
}

function checkCategory() {
	if (check) {
		const val = $("#category").val();
		const ele = $("#category").siblings(".error")[0];
		if (val === "") {
			$(ele).text("Required")
			$(ele).show()
			error = true;
		}
		else if (val.length <=5) {
			$(ele).text("Category must contain atleast 5 characters")
			$(ele).show()
			error = true;
		}
		else {
			$(ele).text("")
			$(ele).hide()
			error = true;
			error = false
		}
	}
}

function checkImage()
{
	if(check)
	{
		const img = $("#img-file")[0];
	const files = img.files;
	if(files.length > 0)
	{
		error=false
	}else{
		$("#upload-indicator").show()
		$("#upload-indicator").addClass("error")
		error=true;
	}
	}
}


//For Submit


function handleSubmit() {
	check = true;
	checkName();
	checkDesc();
	checkPrice();
	checkCategory();
	checkImage();
	if(!error)
	{
		$("#addfoodForm").submit()
	}
}


// For Image

function handleFileChange() {
	const fileInput = $("#img-file")[0];
	const files = fileInput.files;
	if (files.length > 0) {
		$("#upload-indicator").hide()
		const file = files[0];
		const preview = document.getElementById("img-preview");
		const fileUrl = URL.createObjectURL(file);
		preview.src = fileUrl;
		$("#upload-remove").show()
		error=false;
	}else{
		error=true;
	}

}
function handleFileRemove() {
	const preview = document.getElementById("img-preview");
	preview.src = "";
	$("#upload-indicator").show();
	$("#upload-remove").hide();
	error=true;
	 $("#img-file").val('')
}
function goBack() {
	window.history.back()
}

