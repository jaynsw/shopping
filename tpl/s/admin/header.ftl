<body>

<!-- Navigation -->

<div class="off-canvas-wrap docs-wrap">
  <div class="inner-wrap">
    <nav class="tab-bar">
      <section class="left-small">
        <a class="left-off-canvas-toggle menu-icon"><span></span></a>
      </section>

      <section class="middle tab-bar-section">
        <a href="/"><h1 class="title">
		${navJSON.shopName}
        </h1></a>
      </section>
    </nav>
    
    
    <aside class="left-off-canvas-menu">
      <ul class="off-canvas-list">
      <li><label>Categories</label></li>
<#list navJSON.headerNav as ch>			
		<li><a href="${ch.url}">${ch.title}</a></li>
</#list>
		<li><label>Hi ${_currentUser.nickName}</label></li>
		<li><a href="/tpl/shopping_cart">Cart <span class="label">${_shoppingCartItemCount}</label></a></li>

		<li><a href="/tpl/s/cust/account_orders">Orders</a></li>
		<li><a href="/tpl/s/cust/change_password">Change Password</a></li>
		<li><a href="/weblet/account_action/signOut">Sign Out</a></li>
		<li class="has-form">
        	<form action="/tpl/search">
			
				<input type="text" name="q" placeholder="Search...">
				
			</form>
		</li>
      </ul>
    </aside>

	<section class="main-section">