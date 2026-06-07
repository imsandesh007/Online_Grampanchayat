package com.gp.servlet.citizen;

import com.gp.dao.SchemeDAO;
import com.gp.model.SchemeRegistration;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/citizen/schemes")
public class CitizenSchemeServlet extends HttpServlet {

    private SchemeDAO schemeDAO = new SchemeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int citizenId = (int) req.getSession().getAttribute("userId");
        req.setAttribute("schemes", schemeDAO.getActiveSchemes());
        req.setAttribute("myRegistrations", schemeDAO.getRegistrationsByCitizenId(citizenId));
        req.getRequestDispatcher("/WEB-INF/views/citizen/schemes.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int citizenId = (int) req.getSession().getAttribute("userId");
        int schemeId = Integer.parseInt(req.getParameter("schemeId"));

        if (schemeDAO.alreadyRegistered(schemeId, citizenId)) {
            res.sendRedirect(req.getContextPath() + "/citizen/schemes?msg=already");
            return;
        }

        SchemeRegistration sr = new SchemeRegistration();
        sr.setSchemeId(schemeId);
        sr.setCitizenId(citizenId);
        sr.setAnnualIncome(new BigDecimal(req.getParameter("annualIncome")));
        sr.setOccupation(req.getParameter("occupation"));
        sr.setFamilyMembers(Integer.parseInt(req.getParameter("familyMembers")));
        sr.setRemarks(req.getParameter("remarks"));
        schemeDAO.register(sr);
        res.sendRedirect(req.getContextPath() + "/citizen/schemes?msg=success");
    }
}
