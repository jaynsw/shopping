<#import "common.ftl" as common />

<#set paymentJSON = _documentLoader.get("/conf/payment.json")>

<#set paypalJSON = _documentLoader.get("/conf/paypal.json")>

<#set orderId = _request.getParameter("orderId")>

<#set params = {"orderId",orderId}>
<#set orderJSON = _plugInLoader.load("com.smallwebstore.ex.shopping.plugin.OrderPlugin",params)>
<#set order = orderJSON.order >

<#include "top.ftl" encoding="UTF-8">
<body>
<#if order??>
<#if (order.payment == "paypal")>

<script>

function paypal(){
	$('#paypal-form').submit();
}

</script>

<form id="paypal-form" action="${paypalJSON.url}" method="post"> 
  <!-- Identify your business so that you can collect the payments. --> 

  <input type="hidden" name="business" value="${paypalJSON.account}">
  <!-- Specify a Buy Now button. --> 
  <input type="hidden" name="cmd" value="_cart"> 
  <input type="hidden" name="upload" value="1"> 
  <input type="hidden" name="custom" value="${order._id}">
  <input type="hidden" name="currency_code" value="${_currency}">
  <input type="hidden" name="shipping_1" value="<@common.amount order.shippingAmount!0.00 />">
  <!-- Specify details about the item that buyers will purchase. -->

<#list order.itemList as orderItem>
  <input type="hidden" name="item_name_${orderItem_index + 1}" value="${orderItem.product}[${orderItem.option}]"> 
  <input type="hidden" name="amount_${orderItem_index + 1}" value="<@common.amount orderItem.price />"> 
  <input type="hidden" name="quantity_${orderItem_index + 1}" value="${orderItem.quantity}"> 
</#list>


</form>

</#if>

<script>



jQuery(function($) {

	${order.payment}();

});

</script>

</#if>
</body>
<#include "bottom.ftl" encoding="UTF-8">

