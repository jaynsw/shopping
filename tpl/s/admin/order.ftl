<#import "common.ftl" as common />
<#set orderId = _request.getParameter("orderId")>
<#set params = {"orderId": orderId}>
<#set getOrderJSON = _plugInLoader.load("com.smallwebstore.ex.shopping.plugin.OrderPlugin",params)>



<#set title="PDT">
<#include "top.ftl" encoding="UTF-8">
<#include "header.ftl" encoding="UTF-8">

<#if ((getOrderJSON.order)?? )>
	<#set order = getOrderJSON.order>

<script>


function change_order_status(){

	var status = $("#order-status").val();
	var data = {'orderId': '${order._id}','status':status};
		
	$.post('/weblet/s/admin/admin_action/changeOrderStatus',$.param(data) ,function(data, status,jqXHR) {
		var json = $.parseJSON(data);
		var error = json.error;		
		if (error == 'success') {
			window.location.reload();
		} else {
			show_alert('failed!');
		}
	});
}


jQuery(function($) {


});


</script>

<br/>

<div class="row">
	<div class="large-6 large-centered columns">
<div data-alert style="display: none;" class="alert-box" id="alert-popup">
	<span id="alert-message"></span>
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
				<h6 class="subheader">[<@common.money orderItem.price />] X ${orderItem.quantity}</h6>
			</div>
		</div>
</#list>
	</div>
</div>



	</#if>

<div class="row">
	<div class="large-6 large-centered columns">
		
	
		<div class="panel clearfix">
		
		Order Status:${order.status} 
		<select id="order-status" onchange="change_order_status();">
			<option value="processing">processing</option>
			<option value="shipped">shipped</option>
			<option value="received">received</option>
		</select>
		
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
