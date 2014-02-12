<#import "common.ftl" as common />

<#set contact = _documentLoader.get("/conf/contact.json")>

<#set title="Contact Us">
<#include "header.ftl" encoding="UTF-8">

<div class="container">
<div class="row">		
	<div class="col-md-3 col-md-offset-3">
<h2>Address</h2>
<div>
  ${contact.address.street}<br>
  ${contact.address.city}, ${contact.address.state} ${contact.address.postcode}<br>
  <abbr title="Phone">P:</abbr>${contact.phone}<br>
	<addr title="Email">E:</abbr>${contact.email}
</div>
	<address>${contact.address.street},${contact.address.city}, ${contact.address.state} ${contact.address.postcode}</address>
	</div>
</div>


              
<script>
$(document).ready(function(){
  $("address").each(function(){                         
    var embed ="<iframe width='425' height='350' frameborder='0' scrolling='no'  marginheight='0' marginwidth='0'   src='https://maps.google.com/maps?&amp;q="+ encodeURIComponent( $(this).text() ) +"&amp;output=embed'></iframe>";
                                $(this).html(embed);
                             
   });
});
</script>

</div><!--container-->
<#include "footer.ftl" encoding="UTF-8">
