<#global navJSON = _documentLoader.get("/conf/nav.json")>
<#global _currentUser = _session.getAttribute("_currentUser")>
<#set params = {}>
<#set shoppingCartJSON = _plugInLoader.load("com.smallwebstore.ex.shopping.plugin.ShoppingCartPlugin",params)>					
<#global _shoppingCartItemCount = 0>
<#if shoppingCartJSON??>
	<#list shoppingCartJSON.items as cartItem>  
		<#global _shoppingCartItemCount = _shoppingCartItemCount + cartItem.quantity>
	</#list>
		
</#if>


<#if seo_title??>
	<#set title = seo_title>
<#else>
	<#set title = navJSON.shopName>
</#if>

<#if seo_description??>
	<#set description = seo_description>
<#else>
	<#set description = navJSON.shopName>
</#if>

<#set keywords = "">

<#if seo_keywords??>
	<#set keywords = seo_keywords>
<#else>
<#list navJSON.headerNav as ch>
	<#set keywords = keywords + ch.title>
	<#if ch_has_next >
		<#set keywords = keywords + ",">
	</#if>
</#list>
</#if>

<!doctype html>
<!--[if IE 9]><html class="lt-ie10" lang="en" > <![endif]-->
<html class="no-js" lang="en" data-useragent="Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<title>${title}</title>
		<meta name="description" content="${description}" />
		<meta name="keywords" content="${keywords}" />
		
		<link rel="stylesheet" href="http://www.smallwebstore.com/css/normalize.css">
		<link rel="stylesheet" href="http://www.smallwebstore.com/css/foundation.min.css">
		
		
		<script src="http://www.smallwebstore.com/js/vendor/modernizr.js"></script>
		<script src="http://www.smallwebstore.com/js/vendor/jquery.js"></script>
		
		<script type="text/javascript">
			
			function show_alert(msg){
				$("#alert-message").html(msg);
				$("#alert-popup").show();
			}
		</script>
		
		
	</head>
