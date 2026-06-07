package com.gp.servlet.admin;

import com.gp.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String id = req.getParameter("id");

        if (("activate".equals(action) || "deactivate".equals(action)) && id != null) {
            String status = "activate".equals(action) ? "ACTIVE" : "INACTIVE";
            userDAO.updateStatus(Integer.parseInt(id), status);
            res.sendRedirect(req.getContextPath() + "/admin/users");
            return;
        }

        req.setAttribute("users", userDAO.getAllCitizens());
        req.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(req, res);
    }
}
