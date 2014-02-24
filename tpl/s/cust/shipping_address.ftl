<#import "common.ftl" as common />


<#set addressJSON = _documentLoader.get("/conf/address.json")>
<#if (addressJSON.compulsoryFields)??>
	<#set compulsoryFields=addressJSON.compulsoryFields >
</#if>


<#set title="check out">
<#include "top.ftl" encoding="UTF-8">
<#include "header.ftl" encoding="UTF-8">

<script>

function save_addressBook(){

	var country = $('#address-country').val();
<#if compulsoryFields?seq_contains("country") >	
	if (!country && country.length == 0){
		show_alert("country value can not be empty!");
		return; 
	}
</#if>	

	var street = $('#address-street').val();
<#if compulsoryFields?seq_contains("street") >	
	if (!street && street.length == 0){
		show_alert("street value can not be empty!");
		return; 
	}
</#if>

	var city = $('#address-city').val();
<#if compulsoryFields?seq_contains("city") >	
	if (!city && city.length == 0){
		show_alert("city value can not be empty!");
		return; 
	}
</#if>	

	var state = $('#address-state').val();
<#if compulsoryFields?seq_contains("state") >	
	if (!state && state.length == 0){
		show_alert("state value can not be empty!");
		return; 
	}
</#if>	

	var postcode = $('#address-postcode').val();
<#if compulsoryFields?seq_contains("postcode") >	
	if (!postcode && postcode.length == 0){
		show_alert("postcode value can not be empty!");
		return; 
	}
</#if>	

	var firstName = $('#address-first-name').val();
<#if compulsoryFields?seq_contains("firstName") >	
	if (!firstName && firstName.length == 0){
		show_alert("first name value can not be empty!");
		return; 
	}
</#if>	

	var lastName = $('#address-last-name').val();
<#if compulsoryFields?seq_contains("lastName") >	
	if (!lastName && lastName.length == 0){
		show_alert("last name value can not be empty!");
		return; 
	}
</#if>	

	

	var telephone = $('#address-telephone').val();
<#if compulsoryFields?seq_contains("telephone") >	
	if (!telephone && telephone.length == 0){
		show_alert('telephone name value can not be empty!");
		return; 
	}
</#if>	

	var data = {'country': country,'street':street,'city':city,'state':state,'postcode':postcode,'lastName':lastName,'firstName':firstName,'telephone':telephone};
		
	$.post('/weblet/s/cust/account_action/saveAddressBook',$.param(data) ,function(data, status,jqXHR) {
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


<#set params = {}>
<#set addressBookJSON = _plugInLoader.load("com.smallwebstore.ex.shopping.plugin.AccountAddressBookPlugin",params)>

<div class="row">
	<div class="large-12 columns">
	
		<div data-alert class="alert-box" id="alert-popup" style="display:none;">
			<span id="alert-message"></span>
			<a href="#" class="close">&times;</a>
		</div>
	<#if (addressBookJSON.addressBook)??>
	
		<#set addressBook = addressBookJSON.addressBook>

		
			<div class="panel" id="cur_address_book">
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
				<div class="clearfix">
					<span class="left"><a href="#" class="button tiny" onclick="$('#edit-address-form').show();$('#cur_address_book').hide();return false;">Edit this address</a></span>
					<span class="right"><a href="/tpl/s/cust/shipping" class="button tiny alert">Use this address</a></span>					
				</div>
			</div>
	<#else>
		<script>
			$(document).ready(function(){
				$('#edit-address-form').show();
				$('#cur_address_book').hide();
				
			});
			
		</script>
	</#if>
	
		<div id="edit-address-form" class="clearfix hide">
		<form>
			<fieldset class="panel">
				<legend>Shipping / Billing Address</legend>
				<select id="address-country">
<#list addressJSON.countries as country>
					<option value="${country}">${country}</option>
</#list>				
				</select>
				<input type="text" value="${(addressBook.street)!""}" id="address-street" placeholder="Street" />
				<input type="text" value="${(addressBook.city)!""}"  id="address-city" placeholder="City" />
				<input type="text" value="${(addressBook.state)!""}"  id="address-state" placeholder="State" />
				<input type="text" value="${(addressBook.postcode)!""}"  id="address-postcode" placeholder="Postcode" />
				<input type="text" value="${(addressBook.firstName)!""}"  id="address-first-name" placeholder="First Name"/>
				<input type="text" value="${(addressBook.lastName)!""}"  id="address-last-name" placeholder="Last Name"/>
				<input type="text" value="${(addressBook.telephone)!""}"  id="address-telephone" placeholder="Telephone"/>
				<div>
					<span class="right"><a href="#" class="button tiny"  onclick="save_addressBook();return false;">Save</a></span>
				</div>
			</fieldset>
		</form>
		</div>
		
		
	</div>
</div>


<#include "footer.ftl" encoding="UTF-8">
<#include "bottom.ftl" encoding="UTF-8">
