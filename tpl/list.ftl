<#import "common.ftl" as common />

<#set productFolders = _documentLoader.list("/htdocs/docs/products","file/folder")>



<#set title="list products">
<#include "top.ftl" encoding="UTF-8">
<#include "header.ftl" encoding="UTF-8">


<#if (_currentAccount?? && _owner == _currentAccount.email)>
<div class="right"><a class="btn btn-primary btn-lg" href="/tpl/modules?q=product">Add Products</a></div>
</#if>

<br/> 

<div class="row">
	<div class="large-12 columns">
		<dl class="sub-nav">
			<dt>Tags:</dt>
			<dd class="active"><a href="#">LV</a></dd>
			<dd><a href="#">David</a></dd>
			<dd><a href="#">Channel</a></dd>
			<dd><a href="#">UGG</a></dd>
		</dl>
	</div>
</div>

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
				<div>
					<a href="/tpl/product?id=${productFolder.name}"><img src="${photoPath}?sz=400x400" ></a>
					<div class="panel">
						<h5>${productJSON.name}</h5>
						<h6 class="subheader"><@common.money productJSON.price /></h6>
					</div>
				</div>
			</li>
</#list>
		</ul>
	</div>
</div>


<#include "footer.ftl" encoding="UTF-8">
<#include "bottom.ftl" encoding="UTF-8">
