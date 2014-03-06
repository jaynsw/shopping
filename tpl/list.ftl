<#import "common.ftl" as common />

<#set productFolders = _documentLoader.list("/htdocs/docs/products","file/folder")>



<#set title="list products">
<#include "top.ftl" encoding="UTF-8">
<#include "header.ftl" encoding="UTF-8">

		<dl class="sub-nav">
<#list 	navJSON.headerNav as ch>			
	<dd><a href="${ch.url}">${ch.title}</a></dd>
</#list>
		</dl>



<div class="row">
	<div class="large-12 columns">
		<ul class="small-block-grid-2 medium-block-grid-3 large-block-grid-6">
<#list productFolders as productFolder>	

	<#set folderPath = productFolder.path>
	<#set webPath = productFolder.path?substring(7)>
	<#set photoPath = webPath + "/product.png">
	<#set productPath = folderPath + "/product.json">
	<#set productJSON = _documentLoader.get(productPath)>

			<li>
				<a href="/tpl/product?id=${productFolder.name}"><div>
					<img src="${photoPath}?sz=400x400" >
					
					<span class="label"><@common.money productJSON.price /></span>
					
				</div></a>
			</li>
</#list>
		</ul>
	</div>
</div>


<#include "footer.ftl" encoding="UTF-8">
<#include "bottom.ftl" encoding="UTF-8">
