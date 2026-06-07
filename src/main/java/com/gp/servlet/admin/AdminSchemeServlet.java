package com.gp.servlet.admin;

import com.gp.dao.SchemeDAO;
import com.gp.model.Scheme;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/admin/schemes")
public class AdminSchemeServlet extends HttpServlet {

    private SchemeDAO schemeDAO = new SchemeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String id = req.getParameter("id");

        if ("edit".equals(action) && id != null) {
            req.setAttribute("scheme", schemeDAO.getSchemeById(Integer.parseInt(id)));
            req.getRequestDispatcher("/WEB-INF/views/admin/scheme-form.jsp").forward(req, res);
            return;
        }
        if ("delete".equals(action) && id != null) {
            schemeDAO.deleteScheme(Integer.parseInt(id));
            res.sendRedirect(req.getContextPath() + "/admin/schemes");
            return;
        }
        if ("add".equals(action)) {
            req.getRequestDispatcher("/WEB-INF/views/admin/scheme-form.jsp").forward(req, res);
            return;
        }
        if ("registrations".equals(action)) {
            req.setAttribute("registrations", schemeDAO.getAllRegistrations());
            req.getRequestDispatcher("/WEB-INF/views/admin/scheme-registrations.jsp").forward(req, res);
            return;
        }

        req.setAttribute("schemes", schemeDAO.getAllSchemes());
        req.getRequestDispatcher("/WEB-INF/views/admin/schemes.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("approve".equals(action) || "reject".equals(action)) {
            int regId = Integer.parseInt(req.getParameter("regId"));
            String status = "approve".equals(action) ? "APPROVED" : "REJECTED";
            String remarks = req.getParameter("remarks");
            schemeDAO.updateRegistrationStatus(regId, status, remarks);
            res.sendRedirect(req.getContextPath() + "/admin/schemes?action=registrations");
            return;
        }

        Scheme s = new Scheme();
        String idParam = req.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) s.setId(Integer.parseInt(idParam));

        s.setSchemeName(req.getParameter("schemeName"));
        s.setDescription(req.getParameter("description"));
        s.setEligibility(req.getParameter("eligibility"));
        s.setBenefits(req.getParameter("benefits"));
        s.setLastDate(Date.valueOf(req.getParameter("lastDate")));
        s.setStatus(req.getParameter("status"));

        if (s.getId() > 0) {
            schemeDAO.updateScheme(s);
        } else {
            schemeDAO.addScheme(s);
        }
        res.sendRedirect(req.getContextPath() + "/admin/schemes");
    }
}
