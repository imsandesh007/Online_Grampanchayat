package com.gp.servlet;

import com.gp.dao.UserDAO;
import com.gp.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String fullName = req.getParameter("fullName").trim();
        String email = req.getParameter("email").trim();
        String password = req.getParameter("password").trim();
        String mobile = req.getParameter("mobile").trim();
        String address = req.getParameter("address").trim();

        if (userDAO.emailExists(email)) {
            req.setAttribute("error", "Email already registered. Please login.");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setMobile(mobile);
        user.setAddress(address);

        if (userDAO.register(user)) {
            req.setAttribute("success", "Registration successful! Please login.");
            req.getRequestDispatcher("/login.jsp").forward(req, res);
        } else {
            req.setAttribute("error", "Registration failed. Please try again.");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.sendRedirect(req.getContextPath() + "/register.jsp");
    }
}
