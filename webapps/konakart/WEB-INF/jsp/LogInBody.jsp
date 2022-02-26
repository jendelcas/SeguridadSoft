<%--
//
// (c) 2012 DS Data Systems UK Ltd, All rights reserved.
//
// DS Data Systems and KonaKart and their respective logos, are 
// trademarks of DS Data Systems UK Ltd. All rights reserved.
//
// The information in this document is free software; you can redistribute 
// it and/or modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
// 
// This software is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//
--%>
<%@include file="Taglibs.jsp" %>

<s:set scope="request" var="emailAddr" value="emailAddr"/> 
<%String emailAddr = (String)(request.getAttribute("emailAddr")); %>

<% com.konakart.al.KKAppEng kkEng = (com.konakart.al.KKAppEng) session.getAttribute("konakartKey");  %>
<% com.konakart.al.CustomerMgr customerMgr = kkEng.getCustomerMgr();%>
<% com.konakart.appif.CustomerIf currentCustomer = customerMgr.getCurrentCustomer();%>
<% boolean allowFacebook = kkEng.getConfigAsBoolean("MODULE_OTHER_FACEBOOK_LOGIN_STATUS",false,false);%>
<% boolean allowGoogleSignIn = kkEng.getConfigAsBoolean("MODULE_OTHER_GOOGLE_SIGN_IN_STATUS",false,false);%>
<% boolean allowPayPal = kkEng.getConfigAsBoolean("MODULE_OTHER_PAYPAL_LOGIN_STATUS",false,false);%>
<% boolean isEE = kkEng.isEnterprise();%>

<%if (allowPayPal) {%>
	<script src='https://www.paypalobjects.com/js/external/api.js'></script>
<%}%>
<%if (allowGoogleSignIn) {%>
	<script src="https://apis.google.com/js/client:platform.js?onload=gpStart" async defer></script>
<%}%>

<script type="text/javascript">	

<%if (allowPayPal) {%>
	<% boolean useSandbox = kkEng.getConfigAsBoolean("MODULE_OTHER_PAYPAL_LOGIN_RUN_IN_SANDBOX",true,false);%>
	paypal.use( ['login'], function (login) {
		  login.render ({
		    "appid":"<%=kkEng.getConfig("MODULE_OTHER_PAYPAL_CLIENT_ID")%>",
		    <%if (useSandbox) {%>
		    "authend":"sandbox",
		    <%}%>
		    "scopes":"<%=kkEng.getConfig("MODULE_OTHER_PAYPAL_LOGIN_SCOPES")%>",
		    "containerid":"lippButton",
		    "locale":"en-us",
		    "returnurl":"<%=kkEng.getConfig("MODULE_OTHER_PAYPAL_LOGIN_RETURN_URL")%>"
		  });
		});
<%}%>

<%if (allowFacebook) {%>
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '<%=kkEng.getConfig("MODULE_OTHER_FACEBOOK_APP_ID")%>',
      version    : 'v6.0'
    });
    $("#fb-button").css("display","inline");
  };

  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "//connect.facebook.net/en_US/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));
   
	function fbKKLogin(response) {
		$("#fb-button").hide();
		$("#fb-wait").text('<kk:msg  key="login.body.fb.processing"/>').addClass('fb-loading');
		document.getElementById('loginToken').value = response.authResponse.accessToken;
		document.getElementById('loginType').value = "<%=com.konakart.al.CustomerMgr.FACEBOOK%>";
        fbGetEmail();
	};
	
	
	function fbGetEmail() {
	   FB.api('/me?fields=email', function(response) {
	   	if (response.email == null || response.email.length == 0) {
	   		document.getElementById('social-status').innerHTML = '<kk:msg  key="login.body.fb.no.email"/>';
	   		$("#fb-wait").text('').removeClass('fb-loading');
	   		$("#fb-button").show();
		} else {
			document.getElementById('extLoginForm').submit();
		}	
	   });
	};
<%}%>

<%if (allowGoogleSignIn) {%>
	function gpStart() {
		  gapi.load('auth2', function() {
	        auth2 = gapi.auth2.init({
	            client_id: '<%=kkEng.getConfig("MODULE_OTHER_GOOGLE_SIGN_IN_CLIENT_ID")%>'
	         });
	        $("#gp-button").css("display","inline");
		  });
	};
	
	function gpSignInCallback(authResult) {
		  if (authResult['code']) {

				$("#gp-button").hide();
				$("#gp-wait").text('<kk:msg  key="login.body.gp.processing"/>').addClass('gp-loading');
				document.getElementById('loginToken').value = authResult['code'];
				document.getElementById('loginType').value = "<%=com.konakart.al.CustomerMgr.GOOGLESIGNIN%>";
				document.getElementById('extLoginForm').submit();

		  } else {
			  document.getElementById('social-status').innerHTML = '<kk:msg  key="login.body.gp.no.auth"/>';
		  }
		};	
<%}%>


$(function() {
		$("#password").keydown(function (e){
		    if(e.keyCode == 13){
		    	formValidate('form1', 'continue-button');
		    }
		});

	<%if (allowGoogleSignIn) {%>		
		$('#gp-button').click(function() {
			 auth2.grantOfflineAccess().then(gpSignInCallback);
		});
	<%}%>
	<%if (allowFacebook) {%>
		$("#fb-button").click(function() {
			FB.getLoginStatus(function(response) {
			    if (response==null || response.authResponse == 'undefined' || response.status!='connected') {
			    	FB.login(function(response){
				     	if (response.status === 'connected') {
				     		fbKKLogin(response);
				       	} else if (response.status === 'not_authorized') {
				         	document.getElementById('social-status').innerHTML = '<kk:msg  key="login.body.fb.no.auth"/>';
				       	} else {
				         	document.getElementById('social-status').innerHTML = '<kk:msg  key="login.body.fb.no.auth"/>';
				       	}    
			    	}, {scope: 'email'});
				} else {
					fbKKLogin(response);
				}
			});
		});	
	<%}%>			 
});	
		
</script>

<%if (allowPayPal) {%>
	<style>
		.LIwPP { height: 27px !important;} 
	</style>
<%}%>

			<%if (allowFacebook || allowGoogleSignIn) {%>
				<form action="LoginSubmit.action" id='extLoginForm' method="post">
					<input type="hidden" value="<%=kkEng.getXsrfToken()%>" name="xsrf_token"/>
					<input id="loginToken" name="loginToken" type="hidden"/>
					<input id="loginType" name="loginType" type="hidden"/>
				</form>
			<%}%>
			<%if (allowFacebook || allowGoogleSignIn || allowPayPal) {%> 
				<h1 id="page-title"><kk:msg  key="login.body.use.social.network"/></h1>
    			<div class="content-area rounded-corners">
					<div id="social-status" class="messageStackError">
						<ul>
						<%if (allowFacebook) {%>
							<li>
								<div id="fb-button" style="display: none"><img src="<%=kkEng.getImageBase()%>/btn_facebook_login.png"></div>
								<div id="fb-wait"></div>
							</li>
						<%}%>
						<%if (allowGoogleSignIn) {%>
							<li>
								<div id="gp-button" style="display: none"><img src="<%=kkEng.getImageBase()%>/btn_google_signin.png"></div>		
								<div id="gp-wait"></div>																					
							</li>
						<%}%>
						<%if (allowPayPal) {%>
							<li>
								<div style="display: inline">
									<span id='lippButton'></span>
								</div>
							</li> 
						<%}%>
						</ul>
					
						<%if (customerMgr.getLoginType() != null 
							&& (customerMgr.getLoginType().equals(com.konakart.al.CustomerMgr.FACEBOOK) 
									|| customerMgr.getLoginType().equals(com.konakart.al.CustomerMgr.GOOGLESIGNIN) 
									|| customerMgr.getLoginType().equals(com.konakart.al.CustomerMgr.PAYPAL))) {%> 	    		
							<s:if test="hasActionErrors()">
							   <div class="messageStackError">  
									<s:iterator value="actionErrors">  
										<s:property escape="false"/>
									</s:iterator>  
								</div>  
							</s:if>		    
							<s:if test="hasActionMessages()">
							   <div class="messageStackSuccess">  
									<s:iterator value="actionMessages">  
										<s:property escape="false"/>
									</s:iterator>  
								</div>  
							</s:if>		    
						<%}%>
					</div>					
    			</div>
			<%}%>
			<h1 id="page-title"><kk:msg  key="login.body.sign.in"/></h1>
 	    		<div id="new-account-area" class="content-area rounded-corners">
					<%if (customerMgr.getLoginType() == null) {%> 	    		
					    <s:if test="hasActionErrors()">
						   <div class="messageStackError">  
						        <s:iterator value="actionErrors">  
						            <s:property escape="false"/>
						        </s:iterator>  
			    			</div>  
						</s:if>		    
						<s:if test="hasActionMessages()">
						   <div class="messageStackSuccess">  
						        <s:iterator value="actionMessages">  
						            <s:property escape="false"/>
						        </s:iterator>  
			    			</div>  
						</s:if>		    
					<%}%>
		    		<div class="sign-in-column-left">
			    		<form action="LoginSubmit.action" id="form1" method="post"> 
			    			<input type="hidden" value="<%=kkEng.getXsrfToken()%>" name="xsrf_token"/>
			    			<div class="form-section">
		    				<h3><kk:msg  key="login.body.returning.customer"/></h3>
								<div class="form-input">
									<%if (isEE) {%>
										<label><kk:msg  key="login.body.email.username"/></label>
									<%}else{%>
										<label><kk:msg  key="login.body.email"/></label>
									<%}%>
									<%if (emailAddr != null) {%>
										<input type="text" id="loginUsername" name="loginUsername" value="<%=emailAddr%>">
									<%}else{%>
										<input type="text" id="loginUsername" name="loginUsername">
									<%}%>									
									<span class="validation-msg"></span>	
								</div>
								<div class="form-input">
									<label><kk:msg  key="login.body.password"/></label>
									<input type="password" id="password" name="password" autocomplete="off">
									<span class="validation-msg"></span>	
								</div>
								<div id="sign-in-button-container">	
									<a onclick="javascript:formValidate('form1', 'continue-button');" id="continue-button" class="button small-rounded-corners"><span><kk:msg  key="login.body.sign.in"/></span></a>
									<a href="ForgotPassword.action" class="text-link" id="forgot-password-link"><kk:msg  key="login.body.forgotten.password"/></a>
								</div>
							</div>
						</form>
			    	</div>
					<div class="sign-in-column-right centered">
						<h3><kk:msg  key="login.body.new.customer"/></h3>
						<div>
							<a href="CustomerRegistration.action?forceReg=true" class="button small-rounded-corners"><span><kk:msg  key="login.body.register"/></span></a>											
						</div>
						<div>
						<%if (kkEng.getConfigAsBoolean("ALLOW_CHECKOUT_WITHOUT_REGISTRATION",false)) {%>
							<a href="CustomerRegistration.action" class="button small-rounded-corners"><span><kk:msg  key="login.body.checkout"/></span></a>											
					    <%}%>
					    </div>
					</div>	
	    		</div>






	




