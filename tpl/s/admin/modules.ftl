<#import "common.ftl" as common />

<#set q = _request.getParameter("q")>
<#set storeServer = "store.smallwebstore.com">
<#set port = "8080">
<#set app = "shopping">

<#set moduleFolders = _documentLoader.list("http://${storeServer}:${port}/apps/${app}/modules","file/folder")>
<#set count = 0>
<#set title="modules">
<#include "top.ftl" encoding="UTF-8">
<#include "header.ftl" encoding="UTF-8">



<script>
function install_module(app, module){

	var data = {'app': app,'module':module};
		
	$.post('/weblet/s/admin/file_action/installModule',$.param(data) ,function(data, status,jqXHR) {
		var json = $.parseJSON(data);
		var error = json.error;		
		if (error == 'success') {
			window.location = '/tpl/list';
		
		} else {
			show_alert('failed!');
		}
	});
}
</script>

<div class="row">
	<div class="large-12 columns">
		<ul class="small-block-grid-2 medium-block-grid-3 large-block-grid-6">
		
<#list moduleFolders as moduleFolder>	

	<#set folderPath = moduleFolder.path>
	<#set webPath = "http://${storeServer}:${port}" + moduleFolder.path?substring(7)>
	<#set photoPath = webPath + "/logo.png">
	<#set modulePath = webPath + "/module.json">
	<#set moduleJSON = _documentLoader.get(modulePath)>
	
	
	<#set tag = moduleJSON.tag>
	<#set idx = 0>
	
<#if (tag?? && q??)>
	<#set idx = tag?index_of(q)>
</#if>
<#if (idx >= 0) >
	<#set count = count + 1>
	
<li><div>
				
	<div style="padding:10px"><img src="${photoPath}?sz=150x150"></div>
	<h3>${moduleJSON.name}</h3>
	<a class="button tiny" href="#" onclick="install_module('${app}','${moduleFolder.name}');return false;">Install</a>				
		
</div></li>
	
</#if>
			
</#list>

<#if count == 0>
	<p> Sorry, There is no any products found!</p>
</#if>


<#include "footer.ftl" encoding="UTF-8">
<#include "bottom.ftl" encoding="UTF-8">
