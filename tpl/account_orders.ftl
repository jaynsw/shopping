<#import "common.ftl" as common />

<#set title="account orders">
<#include "top.ftl" encoding="UTF-8">
<#include "header.ftl" encoding="UTF-8">

<#set page = _request.getParameter("page")>
<#if page??>
	<#set pageIndex = page?number>
<#else>
	<#set pageIndex = 1>
	<#set page = '1'>
</#if>

<#set pageCount = 1>



<#if _currentAccount??>

<script>

jQuery(function($) {
	

});


</script>	

<br/>


<#set params = {'page':page}>
<#set ordersJSON = _plugInLoader.load("com.smallwebstore.ex.shopping.plugin.AccountOrdersPlugin",params)>					
<#if (ordersJSON.orders)??>

<#set pageCount = (ordersJSON.count / 50 + 1) >

<#if (ordersJSON.orders?size > 0)>
<div class="row">
	<div class="large-12 large-centered columns">
<table width="100%">
<thead><tr><td>Time</td><td>Name</td><td>Amount</td><td>Status</td></tr></thead>
<tbody>
<#list ordersJSON.orders as order>
<tr>
	<td><a href="/tpl/order?orderId=${order._id}"><@common.dateTime order.creationTime /></a></td>
	<td>${(order.addressBook.firstName)!""} ${(order.addressBook.lastName)!""}</td>
	<td><@common.money order.itemsAmount + order.shippingAmount /></td>
	<td>${order.status!""}</td>
</tr>
</#list>
</tbody>
</table>
	</div>
</div>
</#if>

<div class="row">
	<div class="large-12 large-centered columns">
		<@common.pager pageIndex pageCount '/tpl/account_orders' />
	</div>
</div>
</#if>

<#else>
	<div class="row"><div class="large-6 large-centered columns"><a class="button" href="http://${_website}.${_domain}/tpl/sign_in">sign in</a></div></div>
</#if>



<#include "footer.ftl" encoding="UTF-8">
<#include "bottom.ftl" encoding="UTF-8">
