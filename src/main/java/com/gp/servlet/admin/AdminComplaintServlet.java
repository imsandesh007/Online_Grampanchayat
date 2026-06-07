package com.gp.servlet.admin;

import com.gp.dao.ComplaintDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/complaints")
public class AdminComplaintServlet extends HttpServlet {

    private ComplaintDAO complaintDAO = new ComplaintDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String id = req.getParameter("id");

        if ("view".equals(action) && id != null) {
            req.setAttribute("complaint", complaintDAO.getById(Integer.parseInt(id)));
            req.getRequestDispatcher("/WEB-INF/views/admin/complaint-detail.jsp").forward(req, res);
            return;
        }

        String filter = req.getParameter("filter");
        if (filter != null && !filter.isEmpty()) {
            req.setAttribute("complaints", complaintDAO.getByStatus(filter));
        } else {
            req.setAttribute("complaints", complaintDAO.getAll());
        }
        req.getRequestDispatcher("/WEB-INF/views/admin/complaints.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String status = req.getParameter("status");
        String remarks = req.getParameter("remarks");
        complaintDAO.updateStatus(id, status, remarks);
        res.sendRedirect(req.getContextPath() + "/admin/complaints");
    }
}
