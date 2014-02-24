<#global navJSON = _documentLoader.get("/conf/nav.json")>
<body>

<!-- Navigation -->


			<nav class="top-bar" data-topbar>
				<ul class="title-area">
				<!-- Title Area -->
					<li class="name"><h1><a href="/">${navJSON.shopName}</a></h1></li>
					<li class="toggle-topbar menu-icon"><a href="#"><span>menu</span></a></li>
				</ul>

				<section class="top-bar-section">
				<!-- Right Nav Section -->
					<ul class="right">
<#list 	navJSON.headerNav as ch>			
						<li><a href="${ch.url}">${ch.title}</a></li>
</#list>
<#if _currentUser??>
						<li class="divider"></li>
						<li class="has-dropdown"><a href="#">Hi, ${_currentUser.nickName}</a>
							<ul class="dropdown">
								<li><a href="/tpl/s/cust/account_orders">Orders</a></li>
								<li class="divider"></li>
								<li><a href="/tpl/s/cust/change_password">Change Password</a></li>
								<li class="divider"></li>
								<li><a href="/weblet/account_action/signOut">Sign Out</a></li>
							</ul>
						</li>
<#else>					
						<li class="divider"></li>
						<li><a href="/tpl/sign_in">Sign In/ Sign On</a></li>
</#if>
						<li class="divider"></li>
						<li><a href="/tpl/shopping_cart">Cart <span class="label">${_shoppingCartItemCount}</label></a></li>
						<li class="divider"></li>
						<li class="has-form">
							<div class="row collapse">
								<div class="large-8 small-9 columns"><input type="text" placeholder="Find Stuff"></div>
								<div class="large-4 small-3 columns"><a href="#" class=" button expand">Search</a></div>
							</div>
						</li>
					</ul>
				</section>
			</nav><!-- End Top Bar -->

