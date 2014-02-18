<#import "common.ftl" as common />

<#set tx = _request.getParameter("tx")>
<#set params = {"tx": tx}>
<#set getPDTJSON = _plugInLoader.load("com.smallwebstore.ex.shopping.plugin.PDTPlugin",params)>




<#set title="PDT">
<#include "top.ftl" encoding="UTF-8">
<#include "header.ftl" encoding="UTF-8">


<script>

jQuery(function($) {


});


</script>


<#if ( (getPDTJSON.order)?? && (getPDTJSON.pdt)??)>

	<#set order = getPDTJSON.order>
	<#set pdt = getPDTJSON.pdt>

<br/>

<div class="row">
	<div class="large-12 columns">
		<dl class="sub-nav">
			<dt>Check Out Precss:</dt>
			<dd>Shopping Cart</dd>
			<dd>Billing / Shipping Address</dd>
			<dd>Shipping Options</dd>
			<dd><a href="#">order Review</dd>
			<dd class="active">Payment Result</a></dd>
		</dl>
	</div>	
</div>

<div class="row">
	<div class="large-6 large-centered columns">
<div data-alert class="alert-box" id="alert-popup">
	<span id="alert-message">Congratulations, Payment is successfully!</span>
	<a href="#" class="close">&times;</a>
</div>

	</div>
</div>
					
	<#if (order.itemList)??>

		<#set itemCount = 0>
		<#list order.itemList as orderItem>  
			<#set itemCount = itemCount + orderItem.quantity>
		</#list>
		
		
<div class="row">
	<div class="large-6 large-centered columns">
 		
<#list order.itemList as orderItem> 
 		<div class="row">
 			<div class="large-6 columns">
				<a href="/tpl/product?id=${orderItem.productId}"><img src="/docs/products/${orderItem.productId}/product.png?sz=400x400"  alt="${orderItem.product} ${orderItem.option}" /></a>
			</div>
			<div class="panel large-6 columns">
				<h5>${orderItem.product} [${orderItem.option}]</h5>
				<h6 class="subheader"><@common.money orderItem.price /> X ${orderItem.quantity}</h6>
			</div>
		</div>
</#list>
	</div>
</div>



	</#if>
	
<div class="row">
	<div class="large-6 large-centered columns">
	
		
		<div class="panel clearfix">
	<#if ((order.shipping)?? && (order.payment)??)>
			
			<h3>Shipping</h3>
			<p>[$ <@common.money order.shippingAmount />] ${order.shipping}</p>
			<h3>Payment</h3>
			<p>${order.payment}</p>
			
	</#if>
	
	

<#set params = {}>
<#set addressBookJSON = _plugInLoader.load("com.smallwebstore.ex.shopping.plugin.AccountAddressBookPlugin",params)>					
	<#if (addressBookJSON.addressBook)??>
	
		
	
		<#set addressBook = addressBookJSON.addressBook>

		
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
	</#if>
	
		</div>
	</div>
</div>

	
<#else>
	<div class="row"><div class="large-6 large-centered columns"><a class="button" href="http://${_website}.${_domain}/tpl/sign_in">sign in</a></div></div>
</#if>

<#include "footer.ftl" encoding="UTF-8">
<#include "bottom.ftl" encoding="UTF-8">
