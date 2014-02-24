<#import "common.ftl" as common />

<#set q = _request.getParameter("q")>


<#set productFolders = _documentLoader.list("/htdocs/docs/products","file/folder")>

<#set title="quilt list">
<#include "top.ftl" encoding="UTF-8">
<#include "header.ftl" encoding="UTF-8">

<br/>
<div class="row">
	<div class="large-12 columns">
		<ul class="small-block-grid-2 medium-block-grid-3 large-block-grid-6">
<#list productFolders as productFolder>	

	<#set folderPath = productFolder.path>
	<#set webPath = productFolder.path?substring(7)>
	<#set photoPath = webPath + "/product.png">
	<#set productPath = folderPath + "/product.json">
	<#set productJSON = _documentLoader.get(productPath)>
	<#set showProduct = false>
	<#if q?? >
		<#if (productJSON.tag?? && productJSON.tag?index_of(q) >= 0)>
			<#set showProduct = true>
		</#if>
	<#else>
		<#set showProduct = true>
	</#if>

	<#if showProduct >
			<li>
				<a href="/tpl/product?id=${productFolder.name}"><div>
					<img src="${photoPath}?sz=400x400" >
					<div class="panel">
						<h5>${productJSON.name}</h5>
						<h6 class="subheader"><@common.money productJSON.price /></h6>
					</div>
				</div></a>
			</li>
	</#if>
</#list>
		</ul>
	</div>
</div>


<#include "footer.ftl" encoding="UTF-8">
<#include "bottom.ftl" encoding="UTF-8">
