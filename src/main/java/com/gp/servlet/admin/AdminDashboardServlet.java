package com.gp.servlet.admin;

import com.gp.dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();
    private BirthCertificateDAO bcDAO = new BirthCertificateDAO();
    private DeathCertificateDAO dcDAO = new DeathCertificateDAO();
    private SchemeDAO schemeDAO = new SchemeDAO();
    private ComplaintDAO complaintDAO = new ComplaintDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setAttribute("totalCitizens", userDAO.getTotalCitizens());
        req.setAttribute("pendingBC", bcDAO.countByStatus("PENDING"));
        req.setAttribute("pendingDC", dcDAO.countByStatus("PENDING"));
        req.setAttribute("pendingSchemes", schemeDAO.countRegistrationsByStatus("PENDING"));
        req.setAttribute("pendingComplaints", complaintDAO.countByStatus("PENDING"));
        req.setAttribute("resolvedComplaints", complaintDAO.countByStatus("RESOLVED"));
        req.setAttribute("activeSchemes", schemeDAO.getActiveSchemes().size());

        req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, res);
    }
}
