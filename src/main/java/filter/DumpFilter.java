package filter;

import java.io.ByteArrayOutputStream;
import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Request & Reponse 拦截器，可以用来调试EAI类型的程序。 可以输出接受的内容和输出的内容。
 * 
 * @author
 */
public class DumpFilter implements Filter {

	private static Log logger = LogFactory.getLog(DumpFilter.class);
	private boolean dumpRequest;
	private boolean dumpResponse;

	public class CharResponseWrapper extends HttpServletResponseWrapper {
		private CharArrayWriter output;
		private HashMap headers = new HashMap();

		public String toString() {
			return output.toString();
		}

		public CharResponseWrapper(HttpServletResponse response) {
			super(response);
			output = new CharArrayWriter();
		}

		public PrintWriter getWriter() {
			return new PrintWriter(output);
		}

		public void addHeader(String name, String value) {
			super.addHeader(name, value);
			headers.put(name, value);
		}

		public void setHeader(String name, String value) {
			super.setHeader(name, value);
			headers.put(name, value);
		}

		public void dumpHeaders() {

			Iterator iter = headers.entrySet().iterator();
			while (iter.hasNext()) {
				Map.Entry entry = (Map.Entry) iter.next();
				Object key = entry.getKey();
				Object val = entry.getValue();
				logger.debug("   <<< "+key + " : " + val);
			}
		}
	}
	
	public class CharResponseWrapper2 extends HttpServletResponseWrapper {
		
		private HashMap headers = new HashMap();

		public CharResponseWrapper2(HttpServletResponse response) throws IOException{
			super(response);
		}

		public void addHeader(String name, String value) {
			System.out.println("addHeader...");
			super.addHeader(name, value);
			headers.put(name, value);
		}

		public void setHeader(String name, String value) {
			System.out.println("setHeader...");
			super.setHeader(name, value);
			headers.put(name, value);
		}

		public void dumpHeaders() {

			Iterator iter = headers.entrySet().iterator();
			while (iter.hasNext()) {
				Map.Entry entry = (Map.Entry) iter.next();
				Object key = entry.getKey();
				Object val = entry.getValue();
				logger.debug("   <<< "+key + " : " + val);
			}
		}
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		logger.info("=====" + "DEBUG: " + logger.isDebugEnabled() + ", INFO: " + logger.isInfoEnabled() + ", ERROR: " + logger.isErrorEnabled() + "=====");
		dumpRequest = Boolean.valueOf(filterConfig.getInitParameter("dumpRequest"));
		dumpResponse = Boolean.valueOf(filterConfig.getInitParameter("dumpResponse"));
	}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) servletRequest;
		HttpServletResponse res = (HttpServletResponse) servletResponse;
		if (logger.isDebugEnabled()) {
			logger.debug("");
			logger.debug(">>>>> DEBUG -"+req.getRequestURI()+" Request>>>>>");
//			showAllGets(req);
//			debugRequestParameters(req);
//			debugRequestAttributes(req);
			debugRequestHeaders(req);
//			debugRequestCookies(req);
//			debugSessionAttributes(req);
			logger.debug(">>>>> DEBUG -"+req.getRequestURI()+" Request>>>>>");
		}
		// 必须添加，否则 httpReqest.forward()时出现乱码。
		servletResponse.setCharacterEncoding("UTF-8");

//		PrintWriter out = servletResponse.getWriter();
//		ServletOutputStream sos = servletResponse.getOutputStream();
		
		CharResponseWrapper2 wrapper = new CharResponseWrapper2((HttpServletResponse) servletResponse);
		
		filterChain.doFilter(servletRequest, wrapper);
		
//		sos.print(wrapper.toString());
//		sos.close();
//		out.write(wrapper.toString());
//		out.close();
		
		if (logger.isDebugEnabled()) {
			logger.debug("<<<<<<< DEBUG -"+req.getRequestURI()+" Response<<<<<");
			wrapper.dumpHeaders();
			logger.debug("<<<<<<< DEBUG -"+req.getRequestURI()+" Response<<<<<");
		}
	}

	public void destroy() {
	}

	public void debugRequestParameters(HttpServletRequest request) {
		logger.debug(">>>>> Debug Request Parameters =======");
		Enumeration enumt = request.getParameterNames();
		while (enumt.hasMoreElements()) {
			String str = enumt.nextElement().toString();
			logger.debug("   request.getParameter["+str + "] = " + request.getParameter(str));
		}
		logger.debug(">>>>> Debug Request Parameters =======");
	}

	public void debugRequestAttributes(HttpServletRequest request) {
		logger.debug(">>>>> Debug Request Attributes =======");
		Enumeration enumt = request.getAttributeNames();
		while (enumt.hasMoreElements()) {
			String name = enumt.nextElement().toString();
			logger.debug("   request.getAttribute["+name + "] = " + request.getAttribute(name));
		}
		logger.debug(">>>>> Debug Request Attributes =======");
	}

	public void debugRequestHeaders(HttpServletRequest request) {
		logger.debug(">>>>> Debug Request Headers =======");
		Enumeration enumt = request.getHeaderNames();
		while (enumt.hasMoreElements()) {
			String name = enumt.nextElement().toString();
			logger.debug("   request.getHeader["+name + "] = " + request.getHeader(name));
		}
		logger.debug(">>>>> Debug Request Headers =======");
	}

	public void debugRequestCookies(HttpServletRequest request) {
		logger.debug(">>>>> Debug Request Cookies =======");
		logger.debug("   "+request.getCookies());
		logger.debug(">>>>> Debug Request Cookies =======");
	}

	public void debugSessionAttributes(HttpServletRequest request) {
		if (request.getSession(false)!=null) {
			logger.debug(">>>>> Debug Session Attributes =======");
			Enumeration enumt = request.getSession(false).getAttributeNames();
			while (enumt.hasMoreElements()) {
				String name = enumt.nextElement().toString();
				logger.debug("   session.getAttribute["+name + "] = " + request.getSession(false).getAttribute(name));
			}
			logger.debug(">>>>> Debug Session Attributes =======");
		}
	}


	public void showAllGets(HttpServletRequest req) {
		HttpServletRequest request = req;
		logger.debug(">>> getProtocol: " + request.getProtocol());
		logger.debug(">>> getScheme: " + request.getScheme());
		logger.debug(">>> getServerPort: " + request.getServerPort());
		logger.debug(">>> getRemoteAddr: " + request.getRemoteAddr());
		logger.debug(">>> getContentLength: " + request.getContentLength());
		logger.debug(">>> getContentType: " + request.getContentType());
		logger.debug(">>> getPathTranslated: " + request.getPathTranslated());
		logger.debug(">>> getRemoteUser: " + request.getRemoteUser());
		logger.debug(">>> Servlet Path: " + request.getServletPath());
		logger.debug(">>> getRequestURI: " + req.getRequestURI());
		logger.debug(">>> getContextPath: " + req.getContextPath());
		logger.debug(">>> getMethod: " + req.getMethod());
		logger.debug(">>> getAuthType: " + req.getAuthType());
		logger.debug(">>> getCharacterEncoding: " + req.getCharacterEncoding());
		logger.debug(">>> getPathInfo: " + req.getPathInfo());
		logger.debug(">>> getServerName: " + req.getServerName());
		logger.debug(">>> getRequestURL: " + req.getRequestURL());
		logger.debug(">>> getRemote: " + req.getRemoteHost());
		logger.debug(">>> getRemotePort: " + req.getRemotePort());
		logger.debug(">>> getQueryString: " + req.getQueryString());
		logger.debug(">>> getLocal: " + req.getLocalAddr() + "," + req.getLocalName() + "," + req.getLocalPort() + "," + req.getLocale());
		logger.debug(">>> getRequestedSessionId: " + req.getRequestedSessionId());
	}
}
