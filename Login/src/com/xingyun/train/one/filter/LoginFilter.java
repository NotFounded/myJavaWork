package com.xingyun.train.one.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.xingyun.train.one.pojo.User;


/**
 * 过滤器：拦截未登录的页面
 * @author feijunhui
 *
 */
public class LoginFilter implements Filter {
    public void destroy() {
    }
 
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest)req;
        HttpServletResponse response = (HttpServletResponse)resp;
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        User user = (User)session.getAttribute("user");
        if(user != null){
            chain.doFilter(request,response);
        } else{
            out.println("您还未登录，三秒钟后跳转至登录页面~");
            //TODO
            response.setHeader("refresh","3;index.jsp");
        }
    }
 
    public void init(FilterConfig config) throws ServletException {
 
    }
 
}