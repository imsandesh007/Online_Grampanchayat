package com.gp.servlet.citizen;

import com.gp.dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/citizen/dashboard")
public class CitizenDashboardServlet extends HttpServlet {

    private BirthCertificateDAO bcDAO = new BirthCertificateDAO();
    private DeathCertificateDAO dcDAO = new DeathCertificateDAO();
    private SchemeDAO schemeDAO = new SchemeDAO();
    private ComplaintDAO complaintDAO = new ComplaintDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int citizenId = (int) req.getSession().getAttribute("userId");

        req.setAttribute("bcList", bcDAO.getByCitizenId(citizenId));
        req.setAttribute("dcList", dcDAO.getByCitizenId(citizenId));
        req.setAttribute("myRegistrations", schemeDAO.getRegistrationsByCitizenId(citizenId));
        req.setAttribute("myComplaints", complaintDAO.getByCitizenId(citizenId));
        req.setAttribute("activeSchemes", schemeDAO.getActiveSchemes());

        req.getRequestDispatcher("/WEB-INF/views/citizen/dashboard.jsp").forward(req, res);
    }
}
