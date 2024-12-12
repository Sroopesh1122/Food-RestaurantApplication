<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
   
   .header{
   
     width: 100%;
     background: var(--color-black);
     height: 5vh;
     color: white;
     display: flex;
     justify-content: flex-end;
     align-items: center;
     gap:15px;
   }
   .header .icons {
     gap:4px;
     
    
   }
   .header .icons i{
    cursor: pointer;
   }
   .header .icons i:hover {
	 color: red;
  }
  .header button {
    background: white;
    font-size: 0.95rem;
    border-radius: 6px;
    border: none;
    padding: 2px 6px;
    margin: 0 4px;
  }
  .header button:hover {
	background: #ededed;
}
  

</style>

<div class="header">
 
  <div class="center icons ">
     <i class="fa-brands fa-google"></i>
     <i class="fa-brands fa-facebook"></i>
     <i class="fa-brands fa-twitter"></i>
     <i class="fa-brands fa-instagram"></i>
  </div>
 
   <div>
     <button type="button" >SignIn</button>
     <button type="button" >SignUp</button>
   </div>
 
</div>