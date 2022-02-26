<%--
//
// (c) 2012 DS Data Systems UK Ltd, All rights reserved.
//
// DS Data Systems and KonaKart and their respective logos, are 
// trademarks of DS Data Systems UK Ltd. All rights reserved.
//
// The information in this document is free software; you can redistribute 
// it and/or modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
// 
// This software is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//
--%>
<%@include file="Taglibs.jsp" %>
<% com.konakart.al.KKAppEng kkEng = (com.konakart.al.KKAppEng) session.getAttribute("konakartKey");%>
<% com.konakart.al.CategoryMgr catMgr = kkEng.getCategoryMgr();%>
<% com.konakart.appif.CategoryIf[] cats  = catMgr.getCats();%>
<% com.konakart.al.ProductMgr prodMgr = kkEng.getProductMgr();%>
<% int menuType =  kkEng.getPropertyAsInt("menu.type", 1);%>

<%if (menuType == 2){ %>

	<script>
		$(function() {
			if ($('#side-menu').length && $('#side-menu-mobile').is(":visible")){
				$('#smart-menus').hide();
			}else {
				$('#smart-menus').smartmenus();
			}  
		});
		
		$(window).resize(function() {
			if ($('#side-menu').length && $('#side-menu-mobile').is(":visible")){
				$('#smart-menus').hide();
			}else {
				$('#smart-menus').show();
			}  
		});
	</script>
	
	<ul id="smart-menus" class="sm sm-clean">
	  <li><a href="#"><%=kkEng.getMsg("menu.body.products")%></a>
		<ul>
		<%for (int i = 0; i < cats.length; i++) {%>
			<%com.konakart.appif.CategoryIf cat = cats[i]; %>
			<li>
				<a href='<%="SelectCat.action?catId="+cat.getId()%>'><%=cat.getName()%></a>
				<%if (cat.getChildren() != null && cat.getChildren().length > 0){ %>
					<ul>
					<%for (int j = 0; j < cat.getChildren().length; j++) {%>
						<%com.konakart.appif.CategoryIf child = cat.getChildren()[j]; %>
						<li><a href='<%="SelectCat.action?catId="+child.getId()%>'><%=child.getName()%></a></li>
					<% } %>
					</ul>
				<% } %>
	
			
			</li>
		<% } %>	
		</ul>
	  </li>
	   <li class="has-mega-menu"><a href="#"><%=kkEng.getMsg("menu.body.brands")%></a>
	  	<ul class="mega-menu">
	  		<li>
		   		<% int colCount =  (prodMgr.getAllManuDropList().length / 3);%>
		   		<%if (prodMgr.getAllManuDropList().length % 3 != 0) {%>
						<%colCount += 1; %>
				<% } %>
				<% int breakCount = colCount; %>    		
				<% for (int i = 0; i < prodMgr.getAllManuDropList().length; i++){ %>
					<%if (i==0) {%>
						<div class="column-1-3"><ul>
					<% } else if (i==breakCount){ %>
						</ul></div><div class="column-1-3"><ul>
						<% breakCount += colCount;%>
					<% } %>
					<% com.konakart.al.DropListElement dre = prodMgr.getAllManuDropList()[i];%>
					<li><a href='<%="ShowSearchByManufacturerResultsByLink.action?manuId="+dre.getId()%>'><%=dre.getDesc()%></a></li>
				<% } %>
				</ul></div>
			</li>
		</ul>
	  </li>  
	</ul>

<% } else { %>
	<script>
		$(function() {
			if ($('#side-menu').length && $('#side-menu-mobile').is(":visible")){
				$('#main-menu').hide();
			}else {
				$('#main-menu').smartmenus();
			}  
		});
		$(window).resize(function() {
			if ($('#side-menu').length && $('#side-menu-mobile').is(":visible")){
				$('#main-menu').hide();
			}else {
				$('#main-menu').show();
			}  
		});
	</script>
	<div id="main-menu">
		<%for (int i = 0; i < cats.length; i++) {%>
			<%com.konakart.appif.CategoryIf cat = cats[i]; %>
			<%String menuClass; %>
			<%if (i == cats.length-1){ %>
				<% menuClass = "menu-item rounded-corners last-child"; %>
			<% } else { %>
				<% menuClass = "menu-item rounded-corners"; %>
			<% } %>
			<a href='<%="SelectCat.action?catId="+cat.getId()%>' class="<%=menuClass%>" style="width: auto;"><%=cat.getName()%></a>
		<% } %>					
	</div>
<% } %>	