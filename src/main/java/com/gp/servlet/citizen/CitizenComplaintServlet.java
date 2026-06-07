package com.gp.servlet.citizen;

import com.gp.dao.ComplaintDAO;
import com.gp.model.Complaint;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/citizen/complaints")
public class CitizenComplaintServlet extends HttpServlet {

    private ComplaintDAO complaintDAO = new ComplaintDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int citizenId = (int) req.getSession().getAttribute("userId");
        req.setAttribute("complaints", complaintDAO.getByCitizenId(citizenId));
        req.getRequestDispatcher("/WEB-INF/views/citizen/complaints.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int citizenId = (int) req.getSession().getAttribute("userId");
        Complaint c = new Complaint();
        c.setCitizenId(citizenId);
        c.setCategory(req.getParameter("category"));
        c.setSubject(req.getParameter("subject"));
        c.setDescription(req.getParameter("description"));
        c.setLocation(req.getParameter("location"));
        complaintDAO.file(c);
        res.sendRedirect(req.getContextPath() + "/citizen/complaints?msg=success");
    }
}
