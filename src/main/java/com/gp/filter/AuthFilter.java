package com.gp.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter({"/admin/*", "/citizen/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String uri = req.getRequestURI();
        boolean loggedIn = (session != null && session.getAttribute("user") != null);

        if (!loggedIn) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");

        // Admin accessing citizen area or vice versa
        if (uri.contains("/admin/") && !"ADMIN".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/citizen/dashboard");
            return;
        }
        if (uri.contains("/citizen/") && !"CITIZEN".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        chain.doFilter(request, response);
    }
}
