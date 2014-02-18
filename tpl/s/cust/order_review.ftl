<#import "common.ftl" as common />

<#set paymentJSON = _documentLoader.get("/conf/payment.json")>



<#set shippings = _session.getAttribute("shippings")>

<#set shipping = _session.getAttribute("shipping")>


<#set title="order review">
<#include "top.ftl" encoding="UTF-8">
<#include "header.ftl" encoding="UTF-8">


<script>

jQuery(function($) {
	save_payment();

});

function save_payment(){
	
	
	var data = {'payment': '${paymentJSON.payment}'};
		
	$.post('/weblet/s/cust/account_action/savePayment',$.param(data) ,function(data, status,jqXHR) {
		var json = $.parseJSON(data);
		var error = json.error;		
		if (error == 'success') {
			
		} else {
			show_alert('failed!');
		}
	});
	
}

function save_order(){

	var data = {};
		
	$.post('/weblet/s/cust/account_action/createOrder',$.param(data) ,function(data, status,jqXHR) {
		var json = $.parseJSON(data);
		var error = json.error;		
		if (error == 'success') {
			window.location = '/tpl/s/cust/payment_gateway?orderId=' + json.order;
		} else {
			show_alert('failed!');
		}
	});
}

</script>	




<#set params = {}>
<#set addressBookJSON = _plugInLoader.load("com.smallwebstore.ex.shopping.plugin.AccountAddressBookPlugin",params)>



<br/>

<div class="row">
	<div class="large-12 columns">
		<dl class="sub-nav">
			<dt>Check Out Precss:</dt>
			<dd>Shopping Cart</dd>
			<dd>Billing / Shipping Address</dd>
			<dd>Shipping Options</dd>
			<dd class="active"><a href="#">order Review</a></dd>
			<dd>Payment Result</dd>
		</dl>
	</div>	
</div>

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
			
		</div>
	</div>
</#list>
	
</div>


</#if>

<div class="row">
	<div class="large-6 large-centered columns">
	
		<div data-alert class="alert-box" id="alert-popup" style="display:none;">
			<span id="alert-message"></span>
			<a href="#" class="close">&times;</a>
		</div>



	<#if (addressBookJSON.addressBook)??>
	
		<#set addressBook = addressBookJSON.addressBook>

		
		<div class="panel" id="cur_address_book">
			<h3>Billing / Shipping Address</h3>
			<ul class="vcard">
				<li class="fn">${addressBook.firstName!""} ${addressBook.lastName!""}</li>
				<li class="street-address">${addressBook.street!""}</li>
				<li class="locality">${addressBook.city!""}</li>
				<li><span class="state">${addressBook.state!""}</span>, <span class="zip">${addressBook.postcode!""}</span></li>
				<li class="country">${addressBook.country!""}</li>
				<li class="telephone">${addressBook.telephone!""}</li>
 				<li class="email"><a href="#">${addressBook.email}</a></li>
			</ul>
		</div>
	
	</#if>
	<#if (shipping??)>
		<div class="panel clearfix">
			
		<#if shippings??>
		<#list shippings as shippingR>
		<#if (shippingR.name == shipping)>
			<h3>Shipping</h3>
			<p>[$ <@common.money shippingR.amount />] ${shippingR.description}</p>
		</#if>
		</#list>
		</#if>	
			
			<div class="right">
				<a href="#" class="button"  onclick="save_order();return false;">Next</a>
			</div>
		</div>
	</#if>
	
	</div>	
</div>	

<#include "footer.ftl" encoding="UTF-8">
<#include "bottom.ftl" encoding="UTF-8">
