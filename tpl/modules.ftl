<#import "common.ftl" as common />

<#set q = _request.getParameter("q")>
<#set storeServer = "store.smallwebstore.com">
<#set port = "8080">
<#set app = "shopping">

<#set moduleFolders = _documentLoader.list("http://${storeServer}:${port}/apps/${app}/modules","file/folder")>
<#set count = 0>
<#set title="list moudles">
<#include "top.ftl" encoding="UTF-8">
<#include "header.ftl" encoding="UTF-8">

<div class="page-content">

<div class="container">
<div class="row">
<script>
function install_module(app, module){

	var data = {'app': app,'module':module};
		
	$.post('/weblet/file_action/installModule',$.param(data) ,function(data, status,jqXHR) {
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
		
<#list moduleFolders as moduleFolder>	

	<#set folderPath = moduleFolder.path>
	<#set webPath = "http://${storeServer}:${port}" + moduleFolder.path?substring(7)>
	<#set photoPath = webPath + "/logo.png">
	<#set modulePath = webPath + "/module.json">
	<#set moduleJSON = _documentLoader.get(modulePath)>
	
	
	<#set tag = moduleJSON.tag>
	<#set idx = -1>
<#if (tag?? && q??)>
	<#set idx = tag?index_of(q)>
	<#if idx != -1 >
		<#set count = count + 1>
	<div class="col-xs-12 col-md-4">
		<div class="well">
			<div class="row">
				
<div style="padding:10px">
	<img class="img-responsive img-thumbnail" src="${photoPath}?sz=150x150">
</div>


<h3>${moduleJSON.name}</h3>
<div><a class="btn btn-primary btn-lg" href="#" onclick="install_module('${app}','${moduleFolder.name}');return false;">Install</a></div>				
			</div>
		</div>
	</div>
	</#if>
	</#if>
			
</#list>

<#if count == 0>
	<p> Sorry, There is no any products found!</p>
</#if>
</div>

</div><!--container-->

</div>
<#include "footer.ftl" encoding="UTF-8">
