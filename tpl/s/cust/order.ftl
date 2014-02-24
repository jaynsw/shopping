<#import "common.ftl" as common />
<#set orderId = _request.getParameter("orderId")>
<#set params = {"orderId": orderId}>
<#set getOrderJSON = _plugInLoader.load("com.smallwebstore.ex.shopping.plugin.OrderPlugin",params)>



<#set title="PDT">
<#include "top.ftl" encoding="UTF-8">
<#include "header.ftl" encoding="UTF-8">

<#if ((getOrderJSON.order)?? )>

<script>

jQuery(function($) {


});


</script>

<br/>

<div class="row">
	<div class="large-12 columns">
<div data-alert style="display: none;" class="alert-box" id="alert-popup">
	<span id="alert-message"></span>
	<a href="#" class="close">&times;</a>
</div>

	</div>
</div>
	
	<#set order = getOrderJSON.order>
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
	<td><a href="/tpl/product?id=${orderItem.productId}"><img src="/docs/products/${orderItem.productId}/product.png?sz=100x100"  alt="${orderItem.product} ${orderItem.option}" /></a></td>
	<td>${orderItem.product} [${orderItem.option}]</td>
	<td>[<@common.money orderItem.price />] X ${orderItem.quantity}</td>
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
			<p>${order.payment},toal amount: [<@common.money (order.itemsAmount + order.shippingAmount) />]</p>

<h3>Instant Payment Notifications</h3>			
<#if (order.IPNList?size > 0)>
<#list order.IPNList as ipn> 
		<h4><@common.dateTime ipn.creationTime /></h4>
		<p>[<@common.money ipn.amount />] payment status:<strong>${ipn.paymentStatus}</strong>, status:${ipn.status}</p>
		<p>${ipn.message}</p>
		<br/>
</#list>
<#else>
	<p>Sorry, no any payment record received!</p>
</#if>			
			
	</#if>

	<br/>
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
