<#import "common.ftl" as common />



<#set title="check out">
<#include "top.ftl" encoding="UTF-8">
<#include "header.ftl" encoding="UTF-8">

<#if _currentAccount??>

<#set params = {}>
<#set shippingRatesJSON = _plugInLoader.load("com.smallwebstore.ex.shopping.plugin.ShippingRatesPlugin",params)>					

<script>

function save_shipping(){
	var shipping = $("input[name=shipping]:checked").val();
	if (!shipping || shipping.length == 0){
		show_alert('please choose a shipping method!');
		return;
	}
	
	var data = {'shipping': shipping};
		
	$.post('/weblet/shopping/account_action/saveShipping',$.param(data) ,function(data, status,jqXHR) {
		var json = $.parseJSON(data);
		var error = json.error;		
		if (error == 'success') {
			window.location = '/tpl/order_review';
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
	<div class="large-12 columns">
		<dl class="sub-nav">
			<dt>Check Out Precss:</dt>
			<dd>Shopping Cart</dd>
			<dd>Billing / Shipping Address</dd>
			<dd class="active"><a href="#">Shipping Options</a></dd>
			<dd>order Review</dd>
			<dd>Payment Result</dd>
		</dl>
	</div>	
</div>
		
	


		
<div class="row">
	<div class="large-6 large-centered columns">
	
		<div data-alert class="alert-box" id="alert-popup" style="display:none;">
			<span id="alert-message"></span>
			<a href="#" class="close">&times;</a>
		</div>

<#if (shippingRatesJSON.shippings)??>	
		<div class="panel clearfix">
			<h3>Shipping Method</h3>

			<ul class="no-bullet">
		<#list shippingRatesJSON.shippings as shipping>
    			<li><input name="shipping" type="radio" value="${shipping.name}"/>&nbsp;&nbsp;[<@common.money shipping.amount />] ${shipping.description}</li>
		</#list>
			</ul>	
		
			<div class="right">
				<a href="#" class="button" onclick="save_shipping();return false;">Next</a>
			</div>
		</div>
</#if>
	</div>
</div>

<#else>
	<div class="row"><div class="large-6 large-centered columns"><a class="button" href="http://${_website}.${_domain}/tpl/sign_in">sign in</a></div></div>
</#if>

<#include "footer.ftl" encoding="UTF-8">
<#include "bottom.ftl" encoding="UTF-8">
