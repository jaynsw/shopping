<#global _currentUser = _session.getAttribute("_currentUser")>
<#set params = {}>
<#set shoppingCartJSON = _plugInLoader.load("com.smallwebstore.ex.shopping.plugin.ShoppingCartPlugin",params)>					
<#global _shoppingCartItemCount = 0>
<#if shoppingCartJSON??>
	<#list shoppingCartJSON.items as cartItem>  
		<#global _shoppingCartItemCount = _shoppingCartItemCount + cartItem.quantity>
	</#list>
		
</#if>
<!doctype html>
<!--[if IE 9]><html class="lt-ie10" lang="en" > <![endif]-->
<html class="no-js" lang="en" data-useragent="Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<title>${title!""}</title>

		<link rel="stylesheet" href="http://store.smallwebstore.com/css/normalize.css">
		<link rel="stylesheet" href="http://store.smallwebstore.com/css/foundation.min.css">
		
		
		<script src="http://store.smallwebstore.com/js/vendor/modernizr.js"></script>
		<script src="http://store.smallwebstore.com/js/vendor/jquery.js"></script>
		
		<script type="text/javascript">
			
			function show_alert(msg){
				$("#alert-message").html(msg);
				$("#alert-popup").show();
			}
		</script>
		
		
	</head>
