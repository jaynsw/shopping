<#import "common.ftl" as common />



<#set title="check out">
<#include "top.ftl" encoding="UTF-8">
<#include "header.ftl" encoding="UTF-8">


<script>


function remove_item(productId, option){

	var data = {'productId': productId,'option':option};
		
	$.post('/weblet/anonymous_action/removeItemShoppingCart',$.param(data) ,function(data, status,jqXHR) {
		var json = $.parseJSON(data);
		var error = json.error;		
		if (error == 'success') {
			window.location.reload();
		
		} else {
			show_alert('failed!');
		}
	});
}


</script>

<br/>



<div class="row"><div class="large-12 columns"><a href="/tpl/s/cust/shipping_address" class="button tiny right alert">Checkout</a></div></div>


<#set params = {}>
<#set shoppingCartJSON = _plugInLoader.load("com.smallwebstore.ex.shopping.plugin.ShoppingCartPlugin",params)>					
<#if shoppingCartJSON??>

		<#set itemCount = 0>
		<#list shoppingCartJSON.items as cartItem>  
			<#set itemCount = itemCount + cartItem.quantity>
		</#list>

<#if (itemCount > 0)>

<div class="row">
	<div class="large-12 columns">
<table width="100%">

<#list shoppingCartJSON.items as cartItem>
	<tr>
 		<td><a href="/tpl/product?id=${cartItem.productId}"><img src="/docs/products/${cartItem.productId}/product.png?sz=100x100"  alt="${cartItem.product} ${cartItem.option}" /></a></td>
		<td>${cartItem.product} [${cartItem.option}]</td>
		<td><@common.money cartItem.price /> X ${cartItem.quantity}</td>
		<td><a href="#" class="button tiny" onclick="remove_item('${cartItem.productId}','${cartItem.option}');return false;">Delete</a></td>
	</tr>
</#list>
</table>
	</div>
</div>


</#if>

</#if>


<#include "footer.ftl" encoding="UTF-8">
<#include "bottom.ftl" encoding="UTF-8">
