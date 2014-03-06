<#import "common.ftl" as common />



<#set title="check out">
<#include "top.ftl" encoding="UTF-8">
<#include "header.ftl" encoding="UTF-8">



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
		
	$.post('/weblet/s/cust/account_action/saveShipping',$.param(data) ,function(data, status,jqXHR) {
		var json = $.parseJSON(data);
		var error = json.error;		
		if (error == 'success') {
			window.location = '/tpl/s/cust/order_review';
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
		<ul class="breadcrumbs">
			<li><a href="/">Home</a></li>
			<li class="current">Shipping</li>
		</ul>
	</div>
</div>

<div class="row">
	<div class="large-12 columns">
	
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
				<a href="#" class="button tiny alert" onclick="save_shipping();return false;">Next</a>
			</div>
		</div>
</#if>
	</div>
</div>



<#include "footer.ftl" encoding="UTF-8">
<#include "bottom.ftl" encoding="UTF-8">
