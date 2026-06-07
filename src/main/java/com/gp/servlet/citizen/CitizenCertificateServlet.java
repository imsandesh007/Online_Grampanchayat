package com.gp.servlet.citizen;

import com.gp.dao.BirthCertificateDAO;
import com.gp.dao.DeathCertificateDAO;
import com.gp.model.BirthCertificate;
import com.gp.model.DeathCertificate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/citizen/certificates")
public class CitizenCertificateServlet extends HttpServlet {

    private BirthCertificateDAO bcDAO = new BirthCertificateDAO();
    private DeathCertificateDAO dcDAO = new DeathCertificateDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String type = req.getParameter("type");
        int citizenId = (int) req.getSession().getAttribute("userId");

        if ("birth".equals(type)) {
            req.setAttribute("bcList", bcDAO.getByCitizenId(citizenId));
            req.getRequestDispatcher("/WEB-INF/views/citizen/birth-cert.jsp").forward(req, res);
        } else if ("death".equals(type)) {
            req.setAttribute("dcList", dcDAO.getByCitizenId(citizenId));
            req.getRequestDispatcher("/WEB-INF/views/citizen/death-cert.jsp").forward(req, res);
        } else {
            res.sendRedirect(req.getContextPath() + "/citizen/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String type = req.getParameter("type");
        int citizenId = (int) req.getSession().getAttribute("userId");

        if ("birth".equals(type)) {
            BirthCertificate bc = new BirthCertificate();
            bc.setCitizenId(citizenId);
            bc.setChildName(req.getParameter("childName"));
            bc.setDateOfBirth(Date.valueOf(req.getParameter("dateOfBirth")));
            bc.setPlaceOfBirth(req.getParameter("placeOfBirth"));
            bc.setFatherName(req.getParameter("fatherName"));
            bc.setMotherName(req.getParameter("motherName"));
            bc.setFatherOccupation(req.getParameter("fatherOccupation"));
            bc.setMotherOccupation(req.getParameter("motherOccupation"));
            bc.setAddress(req.getParameter("address"));
            bcDAO.apply(bc);
            res.sendRedirect(req.getContextPath() + "/citizen/certificates?type=birth&msg=success");

        } else if ("death".equals(type)) {
            DeathCertificate dc = new DeathCertificate();
            dc.setCitizenId(citizenId);
            dc.setDeceasedName(req.getParameter("deceasedName"));
            dc.setDateOfDeath(Date.valueOf(req.getParameter("dateOfDeath")));
            dc.setPlaceOfDeath(req.getParameter("placeOfDeath"));
            dc.setCauseOfDeath(req.getParameter("causeOfDeath"));
            dc.setAgeAtDeath(Integer.parseInt(req.getParameter("ageAtDeath")));
            dc.setRelationWithApplicant(req.getParameter("relation"));
            dc.setAddress(req.getParameter("address"));
            dcDAO.apply(dc);
            res.sendRedirect(req.getContextPath() + "/citizen/certificates?type=death&msg=success");
        }
    }
}
