/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.31
 * Generated at: 2022-02-26 01:50:41 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.konakart.app.Content;
import com.konakart.app.ContentDescription;
import com.konakart.appif.ContentIf;

public final class Search_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(5);
    _jspx_dependants.put("jar:file:/C:/KonaKart/webapps/konakart/WEB-INF/lib/struts2-core-kk-2.3.8.jar!/META-INF/struts-tags.tld", Long.valueOf(1355748546000L));
    _jspx_dependants.put("/WEB-INF/kk.tld", Long.valueOf(1640259136000L));
    _jspx_dependants.put("/WEB-INF/jsp/Taglibs.jsp", Long.valueOf(1640259136000L));
    _jspx_dependants.put("/WEB-INF/lib/struts2-core-kk-2.3.8.jar", Long.valueOf(1640253186000L));
    _jspx_dependants.put("/WEB-INF/tiles-jsp.tld", Long.valueOf(1640259136000L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("com.konakart.app.Content");
    _jspx_imports_classes.add("com.konakart.app.ContentDescription");
    _jspx_imports_classes.add("com.konakart.appif.ContentIf");
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fkk_005fmsg_0026_005fkey_005fnobody;

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fkk_005fmsg_0026_005fkey_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fkk_005fmsg_0026_005fkey_005fnobody.release();
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET, POST or HEAD. Jasper also permits OPTIONS");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write('\r');
      out.write('\n');
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
 com.konakart.al.KKAppEng kkEng = (com.konakart.al.KKAppEng) session.getAttribute("konakartKey");
      out.write('\r');
      out.write('\n');
 boolean useSolr = kkEng.isUseSolr();
      out.write('\r');
      out.write('\n');
 boolean showCookieWarning = !kkEng.isAgreedCookies();
      out.write('\r');
      out.write('\n');
 boolean contentEnabled = kkEng.getContentMgr().isEnabled();
      out.write('\r');
      out.write('\n');
 String contentDir = kkEng.getContentImagesDir();
      out.write('\r');
      out.write('\n');
 com.konakart.al.CategoryMgr catMgr = kkEng.getCategoryMgr();
      out.write("\r\n");
      out.write("\r\n");
if (useSolr) { 
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t<script type=\"text/javascript\">\t\r\n");
      out.write("\t/*\r\n");
      out.write("\t * Autocomplete widget\r\n");
      out.write("\t */\r\n");
      out.write("\t$(function() {\r\n");
      out.write("\t\t$( \"#search-input\" ).autocomplete({\r\n");
      out.write("\t\t\tsource: function(request, response) {\r\n");
      out.write("\t\t\t\tif (document.getElementById('kk_portlet_id'))  {\r\n");
      out.write("\t\t\t\t\tAUI().ready('liferay-portlet-url', function(A) { \r\n");
      out.write("\t\t\t\t        var renderURL = Liferay.PortletURL.createResourceURL();\r\n");
      out.write("\t\t\t\t        renderURL.setParameter(\"struts.portlet.action\", \"/SuggestedSearch.action\");\r\n");
      out.write("\t\t\t\t        renderURL.setPortletId(document.getElementById('kk_portlet_id').value);\r\n");
      out.write("\t\t\t\t        renderURL.setWindowState(\"exclusive\");\r\n");
      out.write("\t\t\t\t\t\trenderURL.setParameter(\"term\", request.term);\r\n");
      out.write("\t\t\t\t\t\trenderURL.setParameter(\"categoryId\", $(\"#top-cat-list\").val());\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t$.ajax({\r\n");
      out.write("\t\t\t\t\t\ttype : 'POST',\r\n");
      out.write("\t\t\t\t\t\ttimeout : '20000',\r\n");
      out.write("\t\t\t\t\t\tscriptCharset : \"utf-8\",\r\n");
      out.write("\t\t\t\t\t\tcontentType : \"application/json; charset=utf-8\",\r\n");
      out.write("\t\t\t\t\t\turl : renderURL.toString(),\r\n");
      out.write("\t\t\t\t\t\tdataType : 'json',\r\n");
      out.write("\t\t\t\t\t\tdata : null,\r\n");
      out.write("\t\t\t\t\t       success: function(result, textStatus, jqXHR) {\t\t\t\t\t         \r\n");
      out.write("\t\t\t\t\t      \t\tresponse(result);\r\n");
      out.write("\t\t\t\t\t      }\r\n");
      out.write("\t\t\t\t\t    });\r\n");
      out.write("\t\t\t\t\t});\t\r\n");
      out.write("\t\t\t\t} else {\r\n");
      out.write("\t\t\t\t     $.ajax({\r\n");
      out.write("\t\t\t\t \t\ttype : 'POST',\r\n");
      out.write("\t\t\t\t\t\ttimeout : '20000',\r\n");
      out.write("\t\t\t\t\t\tscriptCharset : \"utf-8\",\r\n");
      out.write("\t\t\t\t\t\tcontentType : \"application/json; charset=utf-8\",\r\n");
      out.write("\t\t\t\t\t\turl : \"SuggestedSearch.action\",\r\n");
      out.write("\t\t\t\t\t\tdataType : 'json',\r\n");
      out.write("\t\t\t\t\t\tdata : '{\"categoryId\":\"'+$(\"#top-cat-list\").val()+'\",'+'\"term\":\"' + request.term + '\"}',\r\n");
      out.write("\t\t\t\t        success: function(result, textStatus, jqXHR) {\t\t\t\t\t         \r\n");
      out.write("\t\t\t\t       \t\tresponse(result);\r\n");
      out.write("\t\t\t\t       }\r\n");
      out.write("\t\t\t\t     });\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t   },\r\n");
      out.write("\t\t\tminLength: 1,\r\n");
      out.write("\t\t\tselect: function( event, ui ) {\r\n");
      out.write("\t\t\t\tvar catId = $(\"#top-cat-list\").val();\r\n");
      out.write("\t\t\t\tself.kkSearch(ui.item.id,ui.item.value,catId);\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t}).data( \"uiAutocomplete\" )._renderItem = function( ul, item ) {\r\n");
      out.write("\t\t\t   ul.addClass('ui-corner-all');\r\n");
      out.write("\t           return $( \"<li class='ui-corner-all'></li>\" )\r\n");
      out.write("\t               .data( \"item.autocomplete\", item )\r\n");
      out.write("\t               .append( \"<a>\"+ item.label + \"</a>\" )\r\n");
      out.write("\t               .appendTo( ul );\r\n");
      out.write("\t\t};\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$(\"#search-button\").click(function (){\r\n");
      out.write("\t\t    \tvar key = document.getElementById('kk_key').value;\r\n");
      out.write("\t\t\t    var text = document.getElementById('search-input').value;\r\n");
      out.write("\t\t\t    var catId = $(\"#top-cat-list\").val();\r\n");
      out.write("\t\t    \tself.kkSearch(key,text,catId);\r\n");
      out.write("\t\t});\t\t\r\n");
      out.write("\t});\t\r\n");
      out.write("\t</script>\r\n");
      out.write("\t\r\n");
      out.write("\t<!-- For posting suggested search query -->\r\n");
      out.write("\t<form action=\"\" id='ssForm' method=\"post\">\r\n");
      out.write("\t\t<input type=\"hidden\" value=\"");
      out.print(kkEng.getXsrfToken());
      out.write("\" name=\"xsrf_token\"/>\r\n");
      out.write("\t\t<input id=\"searchText\" name=\"searchText\" type=\"hidden\"/>\r\n");
      out.write("\t\t<input id=\"manuId\" name=\"manuId\" type=\"hidden\"/>\r\n");
      out.write("\t\t<input id=\"catId\" name=\"catId\" type=\"hidden\"/>\r\n");
      out.write("\t\t<input id=\"prodId\" name=\"prodId\" type=\"hidden\"/>\r\n");
      out.write("\t</form>\r\n");
 } 
      out.write("\t\r\n");
      out.write("\r\n");
if (showCookieWarning) { 
      out.write("\t\r\n");
      out.write("\t<div id=\"cookie-container\">\r\n");
      out.write("\t\t<div id=\"cookie-warning\">\r\n");
      out.write("\t\t\t\t<span style=\"display:table-cell; vertical-align:top;\">");
      if (_jspx_meth_kk_005fmsg_005f0(_jspx_page_context))
        return;
      out.write("</span>\r\n");
      out.write("\t\t\t\t<span style=\"display:table-cell; vertical-align:middle;\"><div id=\"cookie-warn-button\" class=\"button small-rounded-corners\">");
      if (_jspx_meth_kk_005fmsg_005f1(_jspx_page_context))
        return;
      out.write("</div></span>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
 } 
      out.write("\r\n");
      out.write("\r\n");
      out.write("<div id=\"header-container\">\r\n");
      out.write("\t<div id=\"header\">\r\n");
      out.write("\t\t<div id=\"logo\">\r\n");
      out.write("\t\t\t");
 ContentIf logoImg = null;
      out.write("\r\n");
      out.write("\t\t\t");
if (contentEnabled) { 
      out.write("\r\n");
      out.write("\t\t\t\t");
 ContentIf[] logoImgs = kkEng.getContentMgr().getContentForType(1, 13);
      out.write("\r\n");
      out.write("\t\t\t\t");
if (logoImgs.length == 1) { 
      out.write("\r\n");
      out.write("\t\t\t\t\t");
 logoImg = logoImgs[0];
      out.write("\r\n");
      out.write("\t\t\t\t");
 } 
      out.write(" \r\n");
      out.write("\t\t\t");
 } 
      out.write(" \r\n");
      out.write("\r\n");
      out.write("\t\t\t");
if (logoImg == null) { 
      out.write("\r\n");
      out.write("\t\t\t\t");
 logoImg = new Content();
      out.write("\r\n");
      out.write("\t\t\t\t");
 logoImg.setDescription(new ContentDescription());
      out.write("\r\n");
      out.write("\t\t\t\t");
 logoImg.getDescription().setName1("logo.png");
      out.write("\r\n");
      out.write("\t\t\t\t");
 logoImg.getDescription().setTitle("KonaKart logo");
      out.write("\r\n");
      out.write("\t\t\t\t");
 logoImg.setClickUrl("Welcom.action");
      out.write("\r\n");
      out.write("\t\t\t");
 } 
      out.write(" \r\n");
      out.write("\t\t\t<a href=\"");
      out.print(logoImg.getClickUrl());
      out.write("\"><img id=\"logo-1\"  \r\n");
      out.write("\t\t\t    src=\"");
      out.print(kkEng.getImageBase());
      out.write('/');
      out.print(contentDir);
      out.write('/');
      out.print(logoImg.getDescription().getName1());
      out.write("\"\r\n");
      out.write("\t\t\t    alt=\"");
      out.print(logoImg.getDescription().getTitle());
      out.write("\"/></a>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div id=\"search\">\r\n");
      out.write("\t\t\t");
if (useSolr) { 
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t<select id=\"top-cat-list\" class=\"rounded-corners-left\">\r\n");
      out.write("\t\t\t\t\t<option  value=\"-1\">");
      if (_jspx_meth_kk_005fmsg_005f2(_jspx_page_context))
        return;
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t");
for (int i = 0; i < catMgr.getCats().length; i++) {
      out.write("\r\n");
      out.write("\t\t\t\t\t\t");
com.konakart.appif.CategoryIf cat = catMgr.getCats()[i]; 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t");
if (kkEng.getSearchParentCategoryId() == cat.getId()){ 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<option  value=\"");
      out.print(cat.getId());
      out.write("\" selected=\"selected\">");
      out.print(cat.getName());
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t\t");
 } else { 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<option  value=\"");
      out.print(cat.getId());
      out.write('"');
      out.write('>');
      out.print(cat.getName());
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t\t");
 } 
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t");
 } 
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t</select>\r\n");
      out.write("\t\t\t\t<input type=\"text\" id=\"search-input\"  name=\"searchText\" onkeydown=\"javascript:kkKeydown();\">\r\n");
      out.write("\t\t\t\t<input id=\"kk_key\" type=\"hidden\"/>\r\n");
      out.write("\t\t\t\t<a id=\"search-button\" class=\"rounded-corners-right\">");
      if (_jspx_meth_kk_005fmsg_005f3(_jspx_page_context))
        return;
      out.write("</a>\r\n");
      out.write("\t\t\t");
 } else { 
      out.write("\t\r\n");
      out.write("\t\t\t\t<form action=\"QuickSearch.action\" id=\"quickSearchForm\" method=\"post\">\r\n");
      out.write("\t\t\t\t\t<input type=\"hidden\" value=\"");
      out.print(kkEng.getXsrfToken());
      out.write("\" name=\"xsrf_token\"/>\r\n");
      out.write("\t\t\t\t\t<input type=\"hidden\" value=\"true\" name=\"searchInDesc\"/>\r\n");
      out.write("\t\t\t\t\t<input type=\"text\" id=\"search-input\" name=\"searchText\" class=\"rounded-corners-left\">\r\n");
      out.write("\t\t\t\t\t<a id=\"search-button\" class=\"rounded-corners-right\" onclick=\"javascript:document.getElementById('quickSearchForm').submit();\">");
      if (_jspx_meth_kk_005fmsg_005f4(_jspx_page_context))
        return;
      out.write("</a>\r\n");
      out.write("\t\t\t\t</form>\t\r\n");
      out.write("            ");
 } 
      out.write("\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<a id=\"adv-search-link\" href=\"AdvancedSearch.action\">");
      if (_jspx_meth_kk_005fmsg_005f5(_jspx_page_context))
        return;
      out.write("</a>\r\n");
      out.write(" \t</div>\r\n");
      out.write("</div>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }

  private boolean _jspx_meth_kk_005fmsg_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  kk:msg
    com.konakart.kktags.MsgTag _jspx_th_kk_005fmsg_005f0 = (com.konakart.kktags.MsgTag) _005fjspx_005ftagPool_005fkk_005fmsg_0026_005fkey_005fnobody.get(com.konakart.kktags.MsgTag.class);
    boolean _jspx_th_kk_005fmsg_005f0_reused = false;
    try {
      _jspx_th_kk_005fmsg_005f0.setPageContext(_jspx_page_context);
      _jspx_th_kk_005fmsg_005f0.setParent(null);
      // /WEB-INF/jsp/Search.jsp(112,58) name = key type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_kk_005fmsg_005f0.setKey("cookie.warning");
      int _jspx_eval_kk_005fmsg_005f0 = _jspx_th_kk_005fmsg_005f0.doStartTag();
      if (_jspx_th_kk_005fmsg_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fkk_005fmsg_0026_005fkey_005fnobody.reuse(_jspx_th_kk_005fmsg_005f0);
      _jspx_th_kk_005fmsg_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_kk_005fmsg_005f0, _jsp_getInstanceManager(), _jspx_th_kk_005fmsg_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_kk_005fmsg_005f1(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  kk:msg
    com.konakart.kktags.MsgTag _jspx_th_kk_005fmsg_005f1 = (com.konakart.kktags.MsgTag) _005fjspx_005ftagPool_005fkk_005fmsg_0026_005fkey_005fnobody.get(com.konakart.kktags.MsgTag.class);
    boolean _jspx_th_kk_005fmsg_005f1_reused = false;
    try {
      _jspx_th_kk_005fmsg_005f1.setPageContext(_jspx_page_context);
      _jspx_th_kk_005fmsg_005f1.setParent(null);
      // /WEB-INF/jsp/Search.jsp(113,127) name = key type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_kk_005fmsg_005f1.setKey("common.continue");
      int _jspx_eval_kk_005fmsg_005f1 = _jspx_th_kk_005fmsg_005f1.doStartTag();
      if (_jspx_th_kk_005fmsg_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fkk_005fmsg_0026_005fkey_005fnobody.reuse(_jspx_th_kk_005fmsg_005f1);
      _jspx_th_kk_005fmsg_005f1_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_kk_005fmsg_005f1, _jsp_getInstanceManager(), _jspx_th_kk_005fmsg_005f1_reused);
    }
    return false;
  }

  private boolean _jspx_meth_kk_005fmsg_005f2(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  kk:msg
    com.konakart.kktags.MsgTag _jspx_th_kk_005fmsg_005f2 = (com.konakart.kktags.MsgTag) _005fjspx_005ftagPool_005fkk_005fmsg_0026_005fkey_005fnobody.get(com.konakart.kktags.MsgTag.class);
    boolean _jspx_th_kk_005fmsg_005f2_reused = false;
    try {
      _jspx_th_kk_005fmsg_005f2.setPageContext(_jspx_page_context);
      _jspx_th_kk_005fmsg_005f2.setParent(null);
      // /WEB-INF/jsp/Search.jsp(143,25) name = key type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_kk_005fmsg_005f2.setKey("suggested.search.all");
      int _jspx_eval_kk_005fmsg_005f2 = _jspx_th_kk_005fmsg_005f2.doStartTag();
      if (_jspx_th_kk_005fmsg_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fkk_005fmsg_0026_005fkey_005fnobody.reuse(_jspx_th_kk_005fmsg_005f2);
      _jspx_th_kk_005fmsg_005f2_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_kk_005fmsg_005f2, _jsp_getInstanceManager(), _jspx_th_kk_005fmsg_005f2_reused);
    }
    return false;
  }

  private boolean _jspx_meth_kk_005fmsg_005f3(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  kk:msg
    com.konakart.kktags.MsgTag _jspx_th_kk_005fmsg_005f3 = (com.konakart.kktags.MsgTag) _005fjspx_005ftagPool_005fkk_005fmsg_0026_005fkey_005fnobody.get(com.konakart.kktags.MsgTag.class);
    boolean _jspx_th_kk_005fmsg_005f3_reused = false;
    try {
      _jspx_th_kk_005fmsg_005f3.setPageContext(_jspx_page_context);
      _jspx_th_kk_005fmsg_005f3.setParent(null);
      // /WEB-INF/jsp/Search.jsp(155,56) name = key type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_kk_005fmsg_005f3.setKey("suggested.search.search");
      int _jspx_eval_kk_005fmsg_005f3 = _jspx_th_kk_005fmsg_005f3.doStartTag();
      if (_jspx_th_kk_005fmsg_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fkk_005fmsg_0026_005fkey_005fnobody.reuse(_jspx_th_kk_005fmsg_005f3);
      _jspx_th_kk_005fmsg_005f3_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_kk_005fmsg_005f3, _jsp_getInstanceManager(), _jspx_th_kk_005fmsg_005f3_reused);
    }
    return false;
  }

  private boolean _jspx_meth_kk_005fmsg_005f4(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  kk:msg
    com.konakart.kktags.MsgTag _jspx_th_kk_005fmsg_005f4 = (com.konakart.kktags.MsgTag) _005fjspx_005ftagPool_005fkk_005fmsg_0026_005fkey_005fnobody.get(com.konakart.kktags.MsgTag.class);
    boolean _jspx_th_kk_005fmsg_005f4_reused = false;
    try {
      _jspx_th_kk_005fmsg_005f4.setPageContext(_jspx_page_context);
      _jspx_th_kk_005fmsg_005f4.setParent(null);
      // /WEB-INF/jsp/Search.jsp(161,131) name = key type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_kk_005fmsg_005f4.setKey("suggested.search.search");
      int _jspx_eval_kk_005fmsg_005f4 = _jspx_th_kk_005fmsg_005f4.doStartTag();
      if (_jspx_th_kk_005fmsg_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fkk_005fmsg_0026_005fkey_005fnobody.reuse(_jspx_th_kk_005fmsg_005f4);
      _jspx_th_kk_005fmsg_005f4_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_kk_005fmsg_005f4, _jsp_getInstanceManager(), _jspx_th_kk_005fmsg_005f4_reused);
    }
    return false;
  }

  private boolean _jspx_meth_kk_005fmsg_005f5(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  kk:msg
    com.konakart.kktags.MsgTag _jspx_th_kk_005fmsg_005f5 = (com.konakart.kktags.MsgTag) _005fjspx_005ftagPool_005fkk_005fmsg_0026_005fkey_005fnobody.get(com.konakart.kktags.MsgTag.class);
    boolean _jspx_th_kk_005fmsg_005f5_reused = false;
    try {
      _jspx_th_kk_005fmsg_005f5.setPageContext(_jspx_page_context);
      _jspx_th_kk_005fmsg_005f5.setParent(null);
      // /WEB-INF/jsp/Search.jsp(165,55) name = key type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_kk_005fmsg_005f5.setKey("header.advanced.search");
      int _jspx_eval_kk_005fmsg_005f5 = _jspx_th_kk_005fmsg_005f5.doStartTag();
      if (_jspx_th_kk_005fmsg_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fkk_005fmsg_0026_005fkey_005fnobody.reuse(_jspx_th_kk_005fmsg_005f5);
      _jspx_th_kk_005fmsg_005f5_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_kk_005fmsg_005f5, _jsp_getInstanceManager(), _jspx_th_kk_005fmsg_005f5_reused);
    }
    return false;
  }
}
