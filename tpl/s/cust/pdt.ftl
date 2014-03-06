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
		<ul class="breadcrumbs">
			<li><a href="/">Home</a></li>
			<li class="current">PDT</li>
		</ul>
	</div>
</div>

<div class="row">
	<div class="large-12 columns">
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
	<div class="large-12 columns">
 <table width="100%">
<#list order.itemList as orderItem> 
<tr>
	<td><a href="/tpl/product?id=${orderItem.productId}"><img src="/docs/products/${orderItem.productId}/product.png?sz=100x100"  alt="${orderItem.product} ${orderItem.option}" /></a><td>
	<td>${orderItem.product} [${orderItem.option}]</td>
	<td><@common.money orderItem.price /> X ${orderItem.quantity}</td>
			
</tr>
</#list>
</table>
	</div>
</div>


	</#if>
	
<div class="row">
	<div class="large-12 columns">
	
		
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


</#if>

<#include "footer.ftl" encoding="UTF-8">
<#include "bottom.ftl" encoding="UTF-8">
