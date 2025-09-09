<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Registrazione</title>
  <link rel="stylesheet" href="css/Login.css?v=1.0">
</head>
<body>
  <!-- From Uiverse.io by ilkhoeri --> 
<div class="card">
  <input
    value=""
    class="blind-check"
    type="checkbox"
    id="blind-input"
    name="blindcheck"
    hidden=""
  />
	<input type="checkbox" id="blind-check" class="blind-check" hidden>
	


  <form class="form" action="register" method="POST">
    <div class="title">Benvenuto</div>

    <label class="label_input" for="name">Nome</label>
    <input
      placeholder="Es. Mario Rossi"
      spellcheck="false"
      class="input"
      type="name"
      name="name"
      id="name"
    />
    
    <label class="label_input" for="telefono">Telefono</label>
    <input type="tel" name="telefono" id="telefono"
       class="input"
       placeholder="Es. +39 333 1234567"
       pattern="^\+?[0-9\s\-]{7,15}$"
       required>
    
    
    <label class="label_input" for="email">Email</label>
    <input
	  placeholder="Es. mariorossi@example.com"
	  spellcheck="false"
	  class="input"
	  type="email"
	  name="email"
	  id="email"
	  required
	  pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
	/>

    <div class="field">
      <label class="label_input" for="password">Password</label>
      

    <input
      spellcheck="false"
      class="input"
      type="password"
      name="password"
      id="password"
    />
    <a href="" class="link-forgot">Password Dimenticata?</a>
    <button id="showbtn" type="button" onclick="hide()">Mostra</button>
    </div>
    
    
    <button class="submit" type="submit">Registrati</button>
    
  </form>


  <label for="blind-input" class="avatar">
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="35"
      height="35"
      viewBox="0 0 64 64"
      id="monkey"
    >
      <ellipse cx="53.7" cy="33" rx="8.3" ry="8.2" fill="#89664c"></ellipse>
      <ellipse cx="53.7" cy="33" rx="5.4" ry="5.4" fill="#ffc5d3"></ellipse>
      <ellipse cx="10.2" cy="33" rx="8.2" ry="8.2" fill="#89664c"></ellipse>
      <ellipse cx="10.2" cy="33" rx="5.4" ry="5.4" fill="#ffc5d3"></ellipse>
      <g fill="#89664c">
        <path
          d="m43.4 10.8c1.1-.6 1.9-.9 1.9-.9-3.2-1.1-6-1.8-8.5-2.1 1.3-1 2.1-1.3 2.1-1.3-20.4-2.9-30.1 9-30.1 19.5h46.4c-.7-7.4-4.8-12.4-11.8-15.2"
        ></path>
        <path
          d="m55.3 27.6c0-9.7-10.4-17.6-23.3-17.6s-23.3 7.9-23.3 17.6c0 2.3.6 4.4 1.6 6.4-1 2-1.6 4.2-1.6 6.4 0 9.7 10.4 17.6 23.3 17.6s23.3-7.9 23.3-17.6c0-2.3-.6-4.4-1.6-6.4 1-2 1.6-4.2 1.6-6.4"
        ></path>
      </g>
      <path
        d="m52 28.2c0-16.9-20-6.1-20-6.1s-20-10.8-20 6.1c0 4.7 2.9 9 7.5 11.7-1.3 1.7-2.1 3.6-2.1 5.7 0 6.1 6.6 11 14.7 11s14.7-4.9 14.7-11c0-2.1-.8-4-2.1-5.7 4.4-2.7 7.3-7 7.3-11.7"
        fill="#e0ac7e"
      ></path>
      <g fill="#3b302a" class="monkey-eye-nose">
        <path
          d="m35.1 38.7c0 1.1-.4 2.1-1 2.1-.6 0-1-.9-1-2.1 0-1.1.4-2.1 1-2.1.6.1 1 1 1 2.1"
        ></path>
        <path
          d="m30.9 38.7c0 1.1-.4 2.1-1 2.1-.6 0-1-.9-1-2.1 0-1.1.4-2.1 1-2.1.5.1 1 1 1 2.1"
        ></path>
        <ellipse
          cx="40.7"
          cy="31.7"
          rx="3.5"
          ry="4.5"
          class="monkey-eye-r"
        ></ellipse>
        <ellipse
          cx="23.3"
          cy="31.7"
          rx="3.5"
          ry="4.5"
          class="monkey-eye-l"
        ></ellipse>
      </g>
    </svg>
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="35"
      height="35"
      viewBox="0 0 64 64"
      id="monkey-hands"
    >
      <path
        fill="#89664C"
        d="M9.4,32.5L2.1,61.9H14c-1.6-7.7,4-21,4-21L9.4,32.5z"
      ></path>
      <path
        fill="#FFD6BB"
        d="M15.8,24.8c0,0,4.9-4.5,9.5-3.9c2.3,0.3-7.1,7.6-7.1,7.6s9.7-8.2,11.7-5.6c1.8,2.3-8.9,9.8-8.9,9.8
	s10-8.1,9.6-4.6c-0.3,3.8-7.9,12.8-12.5,13.8C11.5,43.2,6.3,39,9.8,24.4C11.6,17,13.3,25.2,15.8,24.8"
      ></path>
      <path
        fill="#89664C"
        d="M54.8,32.5l7.3,29.4H50.2c1.6-7.7-4-21-4-21L54.8,32.5z"
      ></path>
      <path
        fill="#FFD6BB"
        d="M48.4,24.8c0,0-4.9-4.5-9.5-3.9c-2.3,0.3,7.1,7.6,7.1,7.6s-9.7-8.2-11.7-5.6c-1.8,2.3,8.9,9.8,8.9,9.8
	s-10-8.1-9.7-4.6c0.4,3.8,8,12.8,12.6,13.8c6.6,1.3,11.8-2.9,8.3-17.5C52.6,17,50.9,25.2,48.4,24.8"
      ></path>
    </svg>
  </label>
   <p style="text-align: center; color:#fff;">
    Hai già un account? <a href="login">Effettua L'accesso</a>
  </p>

  <div class="brand">
  <a href="/Italicious/home">
    <img src="img/loghi/logo.png" alt="Italicious Logo" class="brand-logo">
  </a>
</div>

</div>
   


  <!-- Registrazione -->

</body>
<script>
	var card = document.getElementById("card");
	var passInput = document.getElementById("password");
	var showbtn = document.getElementById("showbtn");
	var occhi =document.getElementById("blind-check");
	
	passInput.addEventListener("focus", () => {
		  if (passInput.type === "password") {
		    document.getElementById("blind-check").checked = true;
		  }
		});
	passInput.addEventListener("blur", () => {
		  if (passInput.type === "password") {
		    document.getElementById("blind-check").checked = false;
		  }
		});
	
	function hide(){
		if (passInput.type === "password") {
			passInput.type = "text";
			showbtn.textContent = "Nascondi";
			occhi.checked=false;
		    } else {
		    	passInput.type = "password";
		    	showbtn.textContent = "Mostra";
		    	occhi.checked=true;
		    }
	}
	
	
  document.addEventListener("DOMContentLoaded", function () {
    const toggleCheckbox = document.getElementById("blind-input");
    const passwordInput = document.getElementById("password");

    toggleCheckbox.addEventListener("input", function () {
    
      passwordInput.type = this.checked ? "text" : "password";
      passwordInput.focus();
      passwordInput.setSelectionRange(passwordInput.value.length, passwordInput.value.length);
    
    });
  });
  //VALIDAZIONE MAIL
    const emailInput = document.getElementById("email");
  		emailInput.addEventListener("blur", () => {
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!regex.test(emailInput.value)) {
      emailInput.classList.add("border-red-500");
      alert("Inserisci un'email valida!");
    } else {
      emailInput.classList.remove("border-red-500");
    }
  });
  
</script>
</html>