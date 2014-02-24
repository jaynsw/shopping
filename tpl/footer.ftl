	<footer class="row">
		<div class="large-12 columns">
		<hr>

			<div class="row">
				<div class="large-6 columns"><p>Powered by <a href="http://store.smallwebstore.com/tpl/apps"><strong>smallwebstore</strong></a></p></div>
				<div class="large-6 columns">
					<ul class="inline-list right">
<#list navJSON.footerNav as ch>					
						<li><a href="${ch.url}">${ch.title}</a></li>
</#list>
					</ul>
				</div>
			</div>
		</div>
	</footer><!-- End Footer -->
	<script src="http://store.smallwebstore.com/js/foundation.min.js"></script>
	
	<script>
		$(document).foundation();
		var doc = document.documentElement;
		doc.setAttribute('data-useragent', navigator.userAgent);
	</script>
</body>
