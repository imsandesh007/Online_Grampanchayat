package com.gp.dao;

import com.gp.model.Scheme;
import com.gp.model.SchemeRegistration;
import com.gp.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SchemeDAO {

    // ---- Scheme CRUD ----

    public List<Scheme> getAllSchemes() {
        List<Scheme> list = new ArrayList<>();
        String sql = "SELECT * FROM schemes ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapScheme(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<Scheme> getActiveSchemes() {
        List<Scheme> list = new ArrayList<>();
        String sql = "SELECT * FROM schemes WHERE status='ACTIVE' ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapScheme(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Scheme getSchemeById(int id) {
        String sql = "SELECT * FROM schemes WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapScheme(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean addScheme(Scheme s) {
        String sql = "INSERT INTO schemes (scheme_name, description, eligibility, benefits, last_date, status) VALUES (?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getSchemeName());
            ps.setString(2, s.getDescription());
            ps.setString(3, s.getEligibility());
            ps.setString(4, s.getBenefits());
            ps.setDate(5, s.getLastDate());
            ps.setString(6, s.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public boolean updateScheme(Scheme s) {
        String sql = "UPDATE schemes SET scheme_name=?, description=?, eligibility=?, benefits=?, last_date=?, status=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getSchemeName());
            ps.setString(2, s.getDescription());
            ps.setString(3, s.getEligibility());
            ps.setString(4, s.getBenefits());
            ps.setDate(5, s.getLastDate());
            ps.setString(6, s.getStatus());
            ps.setInt(7, s.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public boolean deleteScheme(int id) {
        String sql = "DELETE FROM schemes WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    // ---- Scheme Registrations ----

    public boolean register(SchemeRegistration sr) {
        String sql = "INSERT INTO scheme_registrations (scheme_id, citizen_id, annual_income, occupation, family_members, remarks) VALUES (?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, sr.getSchemeId());
            ps.setInt(2, sr.getCitizenId());
            ps.setBigDecimal(3, sr.getAnnualIncome());
            ps.setString(4, sr.getOccupation());
            ps.setInt(5, sr.getFamilyMembers());
            ps.setString(6, sr.getRemarks());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public boolean alreadyRegistered(int schemeId, int citizenId) {
        String sql = "SELECT id FROM scheme_registrations WHERE scheme_id=? AND citizen_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, schemeId);
            ps.setInt(2, citizenId);
            return ps.executeQuery().next();
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public List<SchemeRegistration> getRegistrationsByCitizenId(int citizenId) {
        List<SchemeRegistration> list = new ArrayList<>();
        String sql = "SELECT sr.*, s.scheme_name, u.full_name as citizen_name FROM scheme_registrations sr JOIN schemes s ON sr.scheme_id=s.id JOIN users u ON sr.citizen_id=u.id WHERE sr.citizen_id=? ORDER BY sr.applied_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, citizenId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapSR(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<SchemeRegistration> getAllRegistrations() {
        List<SchemeRegistration> list = new ArrayList<>();
        String sql = "SELECT sr.*, s.scheme_name, u.full_name as citizen_name FROM scheme_registrations sr JOIN schemes s ON sr.scheme_id=s.id JOIN users u ON sr.citizen_id=u.id ORDER BY sr.applied_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapSR(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public SchemeRegistration getRegistrationById(int id) {
        String sql = "SELECT sr.*, s.scheme_name, u.full_name as citizen_name FROM scheme_registrations sr JOIN schemes s ON sr.scheme_id=s.id JOIN users u ON sr.citizen_id=u.id WHERE sr.id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapSR(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean updateRegistrationStatus(int id, String status, String remarks) {
        String sql = "UPDATE scheme_registrations SET status=?, admin_remarks=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, remarks);
            ps.setInt(3, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public int countRegistrationsByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM scheme_registrations WHERE status=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    private Scheme mapScheme(ResultSet rs) throws SQLException {
        Scheme s = new Scheme();
        s.setId(rs.getInt("id"));
        s.setSchemeName(rs.getString("scheme_name"));
        s.setDescription(rs.getString("description"));
        s.setEligibility(rs.getString("eligibility"));
        s.setBenefits(rs.getString("benefits"));
        s.setLastDate(rs.getDate("last_date"));
        s.setStatus(rs.getString("status"));
        s.setCreatedAt(rs.getTimestamp("created_at"));
        return s;
    }

    private SchemeRegistration mapSR(ResultSet rs) throws SQLException {
        SchemeRegistration sr = new SchemeRegistration();
        sr.setId(rs.getInt("id"));
        sr.setSchemeId(rs.getInt("scheme_id"));
        sr.setSchemeName(rs.getString("scheme_name"));
        sr.setCitizenId(rs.getInt("citizen_id"));
        sr.setCitizenName(rs.getString("citizen_name"));
        sr.setAnnualIncome(rs.getBigDecimal("annual_income"));
        sr.setOccupation(rs.getString("occupation"));
        sr.setFamilyMembers(rs.getInt("family_members"));
        sr.setRemarks(rs.getString("remarks"));
        sr.setStatus(rs.getString("status"));
        sr.setAdminRemarks(rs.getString("admin_remarks"));
        sr.setAppliedDate(rs.getTimestamp("applied_date"));
        sr.setUpdatedDate(rs.getTimestamp("updated_date"));
        return sr;
    }
}
