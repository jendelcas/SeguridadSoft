/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.31
 * Generated at: 2022-02-26 01:50:42 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.Random;
import com.konakart.app.Content;
import com.konakart.app.ContentDescription;
import com.konakart.appif.ContentIf;

public final class BannersBody_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_imports_classes.add("java.util.Random");
    _jspx_imports_classes.add("com.konakart.app.ContentDescription");
    _jspx_imports_classes.add("com.konakart.appif.ContentIf");
  }

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
  }

  public void _jspDestroy() {
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

      out.write('\n');
      out.write("\r\n");
      out.write("\r\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
 com.konakart.al.KKAppEng kkEng = (com.konakart.al.KKAppEng) session.getAttribute("konakartKey");
      out.write('\n');
 boolean hideRow1 =  kkEng.getPropertyAsBoolean("main.page.hide.banner.row1", false);
      out.write('\n');
 boolean hideRow2 =  kkEng.getPropertyAsBoolean("main.page.hide.banner.row2", false);
      out.write('\n');
 boolean contentEnabled = kkEng.getContentMgr().isEnabled();
      out.write('\n');
 String contentDir = kkEng.getContentImagesDir();
      out.write('\n');
      out.write('\n');
if (!hideRow1) { 
      out.write('\n');
      out.write('	');
 ContentIf banner = null;
      out.write('\n');
      out.write('\n');
      out.write('	');
if (contentEnabled) { 
      out.write('\n');
      out.write('	');
      out.write('	');
 ContentIf[] topBanners = kkEng.getContentMgr().getContentForType(2, 1);
      out.write('\n');
      out.write('	');
      out.write('	');
if (topBanners.length >= 1) { 
      out.write("\n");
      out.write("\t\t\t");
 int idx = new Random().nextInt(topBanners.length);
      out.write("\n");
      out.write("\t\t\t");
 banner = topBanners[idx];
      out.write('\n');
      out.write('	');
      out.write('	');
 } 
      out.write(' ');
      out.write('\n');
      out.write('	');
 } 
      out.write(" \n");
      out.write("\n");
      out.write("\t");
if (banner == null) { 
      out.write('\n');
      out.write('	');
      out.write('	');
 banner = new Content();
      out.write('\n');
      out.write('	');
      out.write('	');
 banner.setDescription(new ContentDescription());
      out.write('\n');
      out.write('	');
      out.write('	');
 banner.getDescription().setName1("home_kindle-fire-hd.jpg");
      out.write('\n');
      out.write('	');
      out.write('	');
 banner.getDescription().setName2("home_kindle-fire-hd-medium.jpg");
      out.write('\n');
      out.write('	');
      out.write('	');
 banner.getDescription().setName3("home_kindle-fire-hd-small.jpg");
      out.write('\n');
      out.write('	');
      out.write('	');
 banner.getDescription().setTitle("Kindle fire");
      out.write('\n');
      out.write('	');
      out.write('	');
 banner.setClickUrl("SelectProd.action?prodId=34");
      out.write('\n');
      out.write('	');
 } 
      out.write(" \n");
      out.write("\n");
      out.write("\t<div id=\"slideshow\"  class=\"rounded-corners\" >\n");
      out.write("\t<a href=\"");
      out.print(banner.getClickUrl());
      out.write("\">\n");
      out.write("\t\t<picture id=\"slide-1\" class=\"slide rounded-corners\">\n");
      out.write("\t\t\t<!--[if IE 9]><video style=\"display: none;\"><![endif]-->\n");
      out.write("\t\t\t<source srcset=\"");
      out.print(kkEng.getImageBase());
      out.write('/');
      out.print(contentDir);
      out.write('/');
      out.print(banner.getDescription().getName1());
      out.write("\" media=\"(min-width: 750px)\">\n");
      out.write("\t\t\t<source srcset=\"");
      out.print(kkEng.getImageBase());
      out.write('/');
      out.print(contentDir);
      out.write('/');
      out.print(banner.getDescription().getName2());
      out.write("\" media=\"(min-width: 440px)\">\n");
      out.write("\t\t\t<source srcset=\"");
      out.print(kkEng.getImageBase());
      out.write('/');
      out.print(contentDir);
      out.write('/');
      out.print(banner.getDescription().getName3());
      out.write("\" >\n");
      out.write("\t\t\t<!--[if IE 9]></video><![endif]-->\n");
      out.write("\t\t\t<img srcset=\"");
      out.print(kkEng.getImageBase());
      out.write('/');
      out.print(contentDir);
      out.write('/');
      out.print(banner.getDescription().getName1());
      out.write("\" alt=\"");
      out.print(kkEng.getImageBase());
      out.write('/');
      out.print(contentDir);
      out.write('/');
      out.print(banner.getDescription().getTitle());
      out.write("\">\n");
      out.write("\t\t</picture>\n");
      out.write("\t</a>\n");
      out.write("\t</div>\n");
 } 
      out.write(' ');
      out.write('\n');
      out.write('\n');
if (!hideRow2) { 
      out.write('\n');
      out.write('	');
 ContentIf banner1 = null;
      out.write('\n');
      out.write('	');
 ContentIf banner2 = null;
      out.write('\n');
      out.write('	');
 ContentIf banner3 = null;
      out.write('\n');
      out.write('	');
 ContentIf banner4 = null;
      out.write('\n');
      out.write('\n');
      out.write('	');
if (contentEnabled) { 
      out.write('\n');
      out.write('	');
      out.write('	');
 ContentIf[] subBanners = kkEng.getContentMgr().getContentForType(6, 2);
      out.write('\n');
      out.write('	');
      out.write('	');
if (subBanners.length >= 5) { 
      out.write("\n");
      out.write("\t\t\t");
 banner1 = subBanners[0];
      out.write("\n");
      out.write("\t\t\t");
 banner2 = subBanners[1];
      out.write("\n");
      out.write("\t\t\t\n");
      out.write("\t\t\t");
 banner3 = null;
      out.write("\n");
      out.write("\t\t\t");
if ((int) (Math.random() * 100) > 50) { 
      out.write("\n");
      out.write("\t\t\t\t");
 banner3 = subBanners[2];
      out.write("\n");
      out.write("\t\t\t");
 } else { 
      out.write("\n");
      out.write("\t\t\t\t");
 banner3 = subBanners[3];
      out.write("\n");
      out.write("\t\t\t");
 } 
      out.write(" \n");
      out.write("\t\t\t\n");
      out.write("\t\t\t");
 banner4 = subBanners[4];
      out.write('\n');
      out.write('	');
      out.write('	');
 } 
      out.write(' ');
      out.write('\n');
      out.write('	');
 } 
      out.write(" \n");
      out.write("\n");
      out.write("\t");
if (banner1 == null) { 
      out.write('\n');
      out.write('	');
      out.write('	');
 banner1 = new Content();
      out.write('\n');
      out.write('	');
      out.write('	');
 banner1.setDescription(new ContentDescription());
      out.write('\n');
      out.write('	');
      out.write('	');
 banner1.getDescription().setName1("home_electronics-sale.jpg");
      out.write('\n');
      out.write('	');
      out.write('	');
 banner1.setClickUrl("ShowSpecials.action");
      out.write('\n');
      out.write('	');
 } 
      out.write(" \n");
      out.write("\t\n");
      out.write("\t");
if (banner2 == null) { 
      out.write('\n');
      out.write('	');
      out.write('	');
 banner2 = new Content();
      out.write('\n');
      out.write('	');
      out.write('	');
 banner2.setDescription(new ContentDescription());
      out.write('\n');
      out.write('	');
      out.write('	');
 banner2.getDescription().setName1("home_electronics-sale-2.jpg");
      out.write('\n');
      out.write('	');
      out.write('	');
 banner2.setClickUrl("SelectCat.action?catId=23");
      out.write('\n');
      out.write('	');
 } 
      out.write(" \n");
      out.write("\t\n");
      out.write("\t");
if (banner3 == null) { 
      out.write('\n');
      out.write('	');
      out.write('	');
 banner3 = new Content();
      out.write('\n');
      out.write('	');
      out.write('	');
 banner3.setDescription(new ContentDescription());
      out.write('\n');
      out.write('	');
      out.write('	');
 banner3.getDescription().setName1("home_gifts-for-the-home.jpg");
      out.write('\n');
      out.write('	');
      out.write('	');
 banner3.setClickUrl("SelectCat.action?catId=24");
      out.write('\n');
      out.write('	');
 } 
      out.write(" \n");
      out.write("\t\n");
      out.write("\t");
if (banner4 == null) { 
      out.write('\n');
      out.write('	');
      out.write('	');
 banner4 = new Content();
      out.write('\n');
      out.write('	');
      out.write('	');
 banner4.setDescription(new ContentDescription());
      out.write('\n');
      out.write('	');
      out.write('	');
 banner4.getDescription().setName1("home_iphone-5.jpg");
      out.write('\n');
      out.write('	');
      out.write('	');
 banner4.setClickUrl("SelectProd.action?prodId=35");
      out.write('\n');
      out.write('	');
 } 
      out.write(" \n");
      out.write("\t\n");
      out.write("\t<div id=\"banners\">\n");
      out.write("\t");
if (banner1 != null) { 
      out.write("\n");
      out.write("\t\t<a href=\"");
      out.print(banner1.getClickUrl());
      out.write("\"><img id=\"banner-1\" class=\"banner-small rounded-corners\" \n");
      out.write("\t\t\tsrc=\"");
      out.print(kkEng.getImageBase());
      out.write('/');
      out.print(contentDir);
      out.write('/');
      out.print(banner1.getDescription().getName1());
      out.write("\"/></a>\n");
      out.write("\t");
 } 
      out.write(' ');
      out.write('\n');
      out.write('	');
if (banner2 != null) { 
      out.write("\n");
      out.write("\t\t<a href=\"");
      out.print(banner2.getClickUrl());
      out.write("\"><img id=\"banner-2\" class=\"banner-small rounded-corners\" \n");
      out.write("\t\t\tsrc=\"");
      out.print(kkEng.getImageBase());
      out.write('/');
      out.print(contentDir);
      out.write('/');
      out.print(banner2.getDescription().getName1());
      out.write("\"/></a>\n");
      out.write("\t");
 } 
      out.write(' ');
      out.write('\n');
      out.write('	');
if (banner3 != null) { 
      out.write("\n");
      out.write("\t\t<a href=\"");
      out.print(banner3.getClickUrl());
      out.write("\"><img id=\"banner-3\" class=\"banner-small rounded-corners\" \n");
      out.write("\t\t\tsrc=\"");
      out.print(kkEng.getImageBase());
      out.write('/');
      out.print(contentDir);
      out.write('/');
      out.print(banner3.getDescription().getName1());
      out.write("\"/></a>\n");
      out.write("\t");
 } 
      out.write(' ');
      out.write('\n');
      out.write('	');
if (banner4 != null) { 
      out.write("\n");
      out.write("\t\t<a href=\"");
      out.print(banner4.getClickUrl());
      out.write("\"><img id=\"banner-4\" class=\"banner-small rounded-corners last-child\" \n");
      out.write("\t\t\tsrc=\"");
      out.print(kkEng.getImageBase());
      out.write('/');
      out.print(contentDir);
      out.write('/');
      out.print(banner4.getDescription().getName1());
      out.write("\"/></a>\n");
      out.write("\t");
 } 
      out.write(" \n");
      out.write("\t</div>\n");
 } 
      out.write(" \n");
      out.write("\n");
      out.write("\n");
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
}
