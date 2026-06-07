package com.gp.servlet.admin;

import com.gp.dao.BirthCertificateDAO;
import com.gp.dao.DeathCertificateDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/certificates")
public class AdminCertificateServlet extends HttpServlet {

    private BirthCertificateDAO bcDAO = new BirthCertificateDAO();
    private DeathCertificateDAO dcDAO = new DeathCertificateDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String type = req.getParameter("type");
        String action = req.getParameter("action");
        String id = req.getParameter("id");

        if ("view".equals(action) && id != null) {
            if ("birth".equals(type)) {
                req.setAttribute("bc", bcDAO.getById(Integer.parseInt(id)));
                req.getRequestDispatcher("/WEB-INF/views/admin/cert-detail.jsp").forward(req, res);
            } else {
                req.setAttribute("dc", dcDAO.getById(Integer.parseInt(id)));
                req.getRequestDispatcher("/WEB-INF/views/admin/cert-detail.jsp").forward(req, res);
            }
            return;
        }

        req.setAttribute("birthList", bcDAO.getAll());
        req.setAttribute("deathList", dcDAO.getAll());
        req.getRequestDispatcher("/WEB-INF/views/admin/certificates.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String type = req.getParameter("type");
        int id = Integer.parseInt(req.getParameter("id"));
        String status = req.getParameter("status");
        String remarks = req.getParameter("remarks");

        if ("birth".equals(type)) {
            bcDAO.updateStatus(id, status, remarks);
        } else {
            dcDAO.updateStatus(id, status, remarks);
        }
        res.sendRedirect(req.getContextPath() + "/admin/certificates");
    }
}
