<#import "common.ftl" as common />
<#import "editor.ftl" as editor />

<#set productId = _request.getParameter("id")>

<#set folderPath = "/htdocs/docs/products/" + productId>
<#set webPath = folderPath?substring(7)>
<#set photoPath = webPath + "/product.png?sz=400x400">
<#set productPath = folderPath + "/product.json">
<#set productJSON = _documentLoader.get(productPath)>
<#set photos = _documentLoader.list(folderPath + "/photos","image/*")>

<#set tag="${productJSON.tag}">
<#set sku="${productJSON.sku}">
<#set name="${productJSON.name}">
<#set price="${productJSON.price}">

<#set options="${productJSON.options}">

<#set title="${productJSON.name}">
<#include "top.ftl" encoding="UTF-8">
<#include "header.ftl" encoding="UTF-8">



<#if tag??>
<div class="row">
	<div class="large-12 columns">
		<ul class="breadcrumbs">
<#set lll = "">
<#set pph =  tag?split(",") >
			<li><a href="/">Root</a></li>
<#list pph as ph>
			<li><a href="/tpl/search?q=${ph}">${ph}</a> </li>
</#list>
		</ul>
	</div>
</div>
</#if>
<script>
function delete_product(){

	var data = {'path': '${folderPath}'};
		
	$.post('/weblet/file_action/deleteFile',$.param(data) ,function(data, status,jqXHR) {
		var json = $.parseJSON(data);
		var error = json.error;		
		if (error == 'success') {
			window.location = '/tpl/list';
		
		} else {
			show_alert('failed!');
		}
	});
}

function clone_product(){

	var data = {'path': '${folderPath}'};
		
	$.post('/weblet/file_action/cloneFolder',$.param(data) ,function(data, status,jqXHR) {
		var json = $.parseJSON(data);
		var error = json.error;		
		if (error == 'success') {
			window.location = '/tpl/list';
		
		} else {
			show_alert('failed!');
		}
	});
}

function add_shopping_cart(){
	var quantity = $("#quantity").val();
	var option = $("#option").val();
	var data = {'productId':'${productId}','product':'${name}','sku': '${sku}','price':'${price}','quantity':quantity,'option':option};
		
	$.post('/weblet/shopping/anonymous_action/addItemShoppingCart',$.param(data) ,function(data, status,jqXHR) {
		var json = $.parseJSON(data);
		var error = json.error;		
		if (error == 'success') {
			window.location = '/tpl/shopping_cart';
		
		} else {
			show_alert('failed!');
		}
	});
}
jQuery(function($) {

var spinner = $( ".spinner" ).spinner({
	create: function( event, ui ) {
		//add custom classes and icons
		$(this)
		.next().addClass('btn btn-success').html('<i class="icon-plus"></i>')
		.next().addClass('btn btn-danger').html('<i class="icon-minus"></i>')
	
		//larger buttons on touch devices
		if(ace.click_event == "tap") $(this).closest('.ui-spinner').addClass('ui-spinner-touch');
	}
});

});

</script>

<#if (_currentAccount?? && _owner == _currentAccount.email)>
<div class="row">
	<div class="large-12 columns">
		<ul class="button-group">
			<a class="button small" href="#" onclick="delete_product();return false;">Delete Product</a>
			<a class="button small" href="#" onclick="clone_product();return false;">Clone Product</a>
		</ul>
	</div>
</div>
</#if>

<div class="row">
	<div class="large-8 columns">
<@editor.edit_json folderPath + "/product.json"/>	
<#if (photos?size > 0)>
		<ul class="small-block-grid-2 large-block-grid-4">
<@editor.file folderPath />
<#list photos as photo>	
	<#set webPhoto = photo.path?substring(7)>
			<li><img src="${webPhoto}?sz=400x400" ></li>
</#list>
		</ul>
</#if>
	</div>
	<div class="large-4 columns">	
		<div class="panel clearfix">
			<h3>${name} <small>${sku!""}</small></h3>
			<input id="quantity" name="quantity" type="hidden" value="1" />
				
<#if options??>
	<#set vals = productJSON[options]?split(",")>
			<h3>${options}</h3>
			<select class="form-control" id="option">
	<#list vals as val>
				<option value="${options}:${val}">${val}</option>
	</#list>
			</select>	
</#if>
			<h3><@common.money productJSON.price /></h3>
			<a class="button" href="#" onclick="add_shopping_cart();return false;" >Buy Now</a>			
		</div>
	</div>
</div>
	

<#if (productJSON.attributes?? && productJSON.attributes?size > 0)>	
<div class="row">
	<div class="large-12 columns">
		<table width="100%">
			<tbody>
<#list productJSON.attributes?keys as attrKey>
			<tr>
				<td width="40%">${attrKey}</td>
				<td width="60%">${productJSON.attributes[attrKey]}</td>
			</tr>
</#list>
			</tbody>
		</table>
	</div>
</div>
</#if>

<#if (productJSON.description)?? >
<div class="row">
	<div class="large-12 columns">
${productJSON.description!""}
	</div>
</div>
</#if>

<#include "footer.ftl" encoding="UTF-8">
<#include "bottom.ftl" encoding="UTF-8">