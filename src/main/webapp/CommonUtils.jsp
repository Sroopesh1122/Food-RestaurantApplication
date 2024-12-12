<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet" />
	
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
	defer="defer"></script>
<style>

:root{
   --color-black:#001219;
 }
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	box-shadow: none !important;
	outline: none !important;
}

.animte-spin{
  animation: spin 1s infinite ease-in-out;
}

 @keyframes spin {
        0%{
            transform: rotate(0deg);
        }
        100%{
            transform: rotate(360deg);
        }
        
    }

.center{
  display: flex;
  justify-content: center;
  align-items: center;
}
.input-error{
 border: 1px solid red !important;
}
.error {
	font-size: 0.7rem;
	color: red;
}
.success{
  font-size: 0.7rem;
  color: green !important;
}
.hidden{
 display: none;
}

body{
 width: 100%; 
}

</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
function showNotification(title, icon, message) {
	Swal.fire({
		icon: icon,
		title: title,
		text: message,
		showClass: {
			popup: `
                                 animate__animated
                                 animate__fadeInUp
                                 animate__faster
                               `
		},
		hideClass: {
			popup: `
                                  animate__animated
                                  animate__fadeOutDown
                                  animate__faster
                                `
		}
	});
}

function showNotificationPromise(title, icon, message) {
	  return Swal.fire({
	    icon: icon,
	    title: title,
	    text: message,
	    showClass: {
	      popup: `
	        animate__animated
	        animate__fadeInUp
	        animate__faster
	      `
	    },
	    hideClass: {
	      popup: `
	        animate__animated
	        animate__fadeOutDown
	        animate__faster
	      `
	    }
	  }).then((result) => {
	    return result.isConfirmed;
	  });
	}

	




</script>