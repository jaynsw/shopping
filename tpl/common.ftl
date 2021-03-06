<#macro pager pageIndex pageCount pageURL>

<#set lastPage = pageCount>
<#if (pageIndex < 10)>
  <#set startPage = 1>
  <#set endPage = pageCount>
<#else>
  <#set startPage = pageIndex - 5>
  <#set endPage = pageIndex + 5>
</#if>

<ul class="pagination">
	<li class="arrow><a href="${pageURL}?page=1" >&laquo;</a></li>

<#list startPage..endPage as x>

  <#if (x == pageIndex)> 
	<li class="current"><a href="#">${x}</a></li>
  <#else>
	<li><a href="${pageURL}?page=${x}">${x}</a></li>
  </#if>
</#list>

	<li class="arrow "><a href="${pageURL}?page=${pageCount}" >&raquo;</a></li>
</ul>
</#macro>

<#macro dateTime val>
<#compress>
${val?iso(_timezone)?string("yyyy-MM-dd HH:mm:ss")}
</#compress>
</#macro>

<#macro money p>
<#compress>
${_currency} $${p?string("###0.00")}
</#compress>
</#macro>

<#macro amount p>
<#compress>
${p?string("###0.00")}
</#compress>
</#macro>












