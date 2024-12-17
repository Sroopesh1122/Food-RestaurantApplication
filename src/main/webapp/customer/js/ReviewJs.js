
let stars =
		document.getElementsByClassName("star");

function gfg(n) {
		remove();
		if(n)
		{
			$("#rating-input").val(n+'');
			checkRating()
		}
		for (let i = 0; i < n; i++) {
			if (n == 1) cls = "one";
			else if (n == 2) cls = "two";
			else if (n == 3) cls = "three";
			else if (n == 4) cls = "four";
			else if (n == 5) cls = "five";
			stars[i].className = "star " + cls;
		}
	}

	
	function remove() {
		let i = 0;
		while (i < 5) {
			stars[i].className = "star";
			i++;
		}
	}
	
	function checkRating() {
    const ratingValue = $("#rating-input").val();
    if (!ratingValue) {
        $("#rating-error").text("Please provide a rating");
        return true; 
    } else {
        $("#rating-error").text("");
        return false; 
    }
}

function checkComment() {
    const commentValue = $("#comment-input").val();
    if (!commentValue) {
        $("#comment-error").text("Comment is required");
        return true; 
    } else {
        $("#comment-error").text("");
        return false; 
    }
}

$(document).ready(function () {
   
    $("#rating-input").on("input", function () {
        checkRating();
    });

    $("#comment-input").on("input", function () {
        checkComment();
    });

    $("#submit-btn").on("click", () => {
        const isRatingError = checkRating();
        const isCommentError = checkComment();

        if (!isRatingError && !isCommentError) {
            $("#review-form").submit()
            
        }
    });
});
