<#import "common.ftl" as common />


<#set address = "/tpl/sign_in?redirect=/tpl/shipping_address">
<#set _current_account = _session.getAttribute("_currentUser")>
<#if _current_account??>
<#set address = "/tpl/shipping_address">
</#if>

<#set title="check out">
<#include "top.ftl" encoding="UTF-8">
<#include "header.ftl" encoding="UTF-8">


<script>


function remove_item(productId, option){

	var data = {'productId': productId,'option':option};
		
	$.post('/weblet/shopping/anonymous_action/removeItemShoppingCart',$.param(data) ,function(data, status,jqXHR) {
		var json = $.parseJSON(data);
		var error = json.error;		
		if (error == 'success') {
			window.location = '/tpl/checkout';
		
		} else {
			show_alert('failed!');
		}
	});
}


</script>

<br/>

<div class="row">
	<div class="large-12 columns">
		<dl class="sub-nav">
			<dt>Check Out Precss:</dt>
			<dd class="active"><a href="#">Shopping Cart</a></dd>
			<dd>Billing / Shipping Address</dd>
			<dd>Shipping Options</dd>
			<dd>order Review</dd>
			<dd>Payment Result</dd>
		</dl>
	</div>	
</div>	

<div class="row"><div class="large-12 columns"><a href="${address}" class="button right">Checkout</a></div></div>

<#set params = {}>
<#set shoppingCartJSON = _plugInLoader.load("com.smallwebstore.ex.shopping.plugin.ShoppingCartPlugin",params)>					
<#if shoppingCartJSON??>

		<#set itemCount = 0>
		<#list shoppingCartJSON.items as cartItem>  
			<#set itemCount = itemCount + cartItem.quantity>
		</#list>

<div class="row">
	<div class="large-6 large-centered columns">
 		
<#list shoppingCartJSON.items as cartItem>
 		<div class="row">
 			<div class="large-6 columns">
				<a href="/tpl/product?id=${cartItem.productId}"><img src="/docs/products/${cartItem.productId}/product.png?sz=400x400"  alt="${cartItem.product} ${cartItem.option}" /></a>
			</div>
			
			<div class="panel large-6 columns">
				<h5>${cartItem.product} [${cartItem.option}]</h5>
				<h6 class="subheader"><@common.money cartItem.price /> X ${cartItem.quantity}</h6>
				<a href="#" class="button small alert" onclick="remove_item('${cartItem.productId}','${cartItem.option}');return false;">Delete</a>
			</div>
		</li>
</#list>
	</div>
</div>


</#if>


<#include "footer.ftl" encoding="UTF-8">
<#include "bottom.ftl" encoding="UTF-8">
