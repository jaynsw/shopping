<#set email = _request.getParameter("email") />
<#set password = _request.getParameter("password") />
<#set error = _request.getParameter("error") />
<#set redirect = _request.getParameter("redirect") />


<#set title="Sign In">
<#set pageId="sign_in">

<#include "top.ftl" encoding="UTF-8">
<#include "header.ftl" encoding="UTF-8">



			

<script type="text/javascript" src="http://store.smallwebstore.com/js/md5.js"></script>
<script>
	function sign_in(){
		var email = $("#sign-in-email");
		email = email.val();
		var password = $("#sign-in-pwd").val();

		if (!email || email.length == 0){
			show_alert("email can not be empty!");
			return;
		}

		if (!password || password.length == 0){
			show_alert("password can not be empty!");
			return;
		}
    	
		var data = {'email': email,'password':hex_md5(password)};

<#if redirect??>
		data.redirect = '${redirect}';
</#if>
		
		$.post('/weblet/anonymous_action/signIn',$.param(data) ,function(data, status,jqXHR) {
			var json = $.parseJSON(data);
			var error = json.error;		
			if (error == 'success') {
				window.location = json.redirect;
			} else if (error == 'error_email'){
				show_alert('email is not valid!');
			} else if (error == 'error_password'){
				show_alert('password is not valid!');
			} else if (error == 'email_not_found'){
				show_alert('email is not found!');
			} else if (error == 'password_mismatch'){
				show_alert('password is mismatched!');
			} else {
				show_alert('unknow error!');
			}
		});

	}


	function sign_up(){
		
		var email = $("#sign-up-email").val();
		var password = $("#sign-up-pwd").val();
		var repeatPassword = $("#sign-up-pwd-repeat").val();
		var nickName = $("#sign-up-nickName").val();

		if (!nickName || nickName.length == 0){
			show_alert("nickName can not be empty!");
			return;
		}

		if (!email || email.length == 0){
			show_alert("nickName can not be empty!");
			return;
		}

		if (!password || password.length == 0){
			show_alert("password can not be empty!");
			return;
		}

		if (!repeatPassword || repeatPassword.length == 0 ) {
			show_alert("repeat password can not be empty!");
			return;
		}

		if (repeatPassword != password) {
			show_alert("repeat password and password are not matched!");
			return;
		}
    	var md5Password = hex_md5(password);
    	var data = {'nickName' : nickName, 'password': md5Password, 'email':email};
		
		$.post('/weblet/anonymous_action/signUp', $.param(data), function(data, status,jqXHR) {
			var json = $.parseJSON(data);
			var error = json.error;		
			if (error == 'success') {
				$("#sign-in-email").val(email);
				$("#sign-in-email").val(email);
				$("#sign-in-form").show();
				$('#sign-up-form').hide();
				$('#forget-pwd-form').hide();
			
			} else if (error == 'error_email'){
				show_alert('the email address is not valid!');
			} else if (error == 'error_password'){
				show_alert('this password is not valid!');
			} else if (error == 'error_nickName'){
				show_alert('the nickName is not valid!');
			} else if (error == 'email_alredy_exists'){
				show_alert('the email address already exists!');
			} else if (error == 'server_not_found'){
				show_alert('the server is not found!');

			} else {
				show_alert('unknow error!');
			}
			
		 
		});
    
    }


	function find_password(){
		var email = $("#find-pwd-email").val();
	

		if (!email || email.length == 0){
			show_alert("email can not be empty!");
			return;
		}


    	
		var data = {'email': email};


		
		$.post('/weblet/anonymous_action/findPassword',$.param(data) ,function(data, status,jqXHR) {
			var json = $.parseJSON(data);
			var error = json.error;		
			if (error == 'success') {
				$("#sign-in-email").val(email);
				$("#sign-in-form").show();
				$('#sign-up-form').hide();
				$('#forget-pwd-form').hide();
			
			} else if (error == 'error_email'){
				show_alert('email is not valid!');
			} else if (error == 'email_not_found'){
				show_alert('email is not found!');
			} else {
				show_alert('unknow error!');

			}
		});
	}


</script>


<div class="row">
	<div class="large-6 large-centered columns">
		<div data-alert class="alert-box" id="alert-popup" style="display:none;">
			<span id="alert-message"></span>
			<a href="#" class="close">&times;</a>
		</div>
		<div id="sign-in-form" class="clearfix">
			<form>
				<fieldset class="panel">
					<legend>Sign In</legend>
					<input id="sign-in-email" value="${email!""}" placeholder="Email" type="email" required>
					<input type="password" id="sign-in-pwd" placeholder="Password" required>
					<div>
						<span class="right"><a href="#" class="button tiny" onclick="sign_in();return false;">Sign In</a></span>
					</div>
				</fieldset>
			</form>
			<span class="left"><a href="#" onclick="$('#sign-in-form').hide();$('#forget-pwd-form').hide();$('#sign-up-form').show();return false;">Sign Up</a></span>
			<span class="right"><a href="#" onclick="$('#sign-in-form').hide();$('#forget-pwd-form').show();$('#sign-up-form').hide();return false;">Forget Password</a></span>
		</div>
		
		<div id="sign-up-form" class="clearfix hide">
			<form>
				<fieldset class="panel">
					<legend>Sign Up</legend>
					<input id="sign-up-email" value="${email!""}" placeholder="Email" type="email" required>
					<input type="password" id="sign-up-pwd" placeholder="Password" required>
					<input type="password" id="sign-up-pwd-repeat" placeholder="Repeat Password" required>
					<input type="text" id="sign-up-nickName" placeholder="nick name" required>
					<div>
						<span class="right"><a href="#" class="button tiny" onclick="sign_up();return false;">Sign Up</a></span>
					</div>
				</fieldset>
			</form>
			<span class="left"><a href="#" onclick="$('#sign-in-form').show();$('#forget-pwd-form').hide();$('#sign-up-form').hide();return false;">Sign In</a></span>
			<span class="right"><a href="#" onclick="$('#sign-in-form').hide();$('#forget-pwd-form').show();$('#sign-up-form').hide();return false;">Forget Password</a></span>
		</div>
		
		<div id="forget-pwd-form" class="clearfix hide">
			<form>
				<fieldset class="panel">
					<legend>Sign In</legend>
					<input id="sign-up-email" value="${email!""}" placeholder="Email" type="email" required>
					
					<div>
						<span class="right"><a href="#" class="button tiny" onclick="forget_password();return false;">Email Me</a></span>
					</div>
				</fieldset>
			</form>
			<span class="left"><a href="#" onclick="$('#sign-in-form').show();$('#forget-pwd-form').hide();$('#sign-up-form').hide();return false;">Sign In</a></span>
			<span class="right"><a href="#" onclick="$('#sign-in-form').hide();$('#forget-pwd-form').hide();$('#sign-up-form').show();return false;">Sign Up</a></span>
		</div>
	</div>
</div>





<#include "footer.ftl" encoding="UTF-8">
<#include "bottom.ftl" encoding="UTF-8">
