package com.gp.dao;

import com.gp.model.DeathCertificate;
import com.gp.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DeathCertificateDAO {

    public boolean apply(DeathCertificate dc) {
        String sql = "INSERT INTO death_certificates (citizen_id, deceased_name, date_of_death, place_of_death, cause_of_death, age_at_death, relation_with_applicant, address) VALUES (?,?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, dc.getCitizenId());
            ps.setString(2, dc.getDeceasedName());
            ps.setDate(3, dc.getDateOfDeath());
            ps.setString(4, dc.getPlaceOfDeath());
            ps.setString(5, dc.getCauseOfDeath());
            ps.setInt(6, dc.getAgeAtDeath());
            ps.setString(7, dc.getRelationWithApplicant());
            ps.setString(8, dc.getAddress());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public List<DeathCertificate> getByCitizenId(int citizenId) {
        List<DeathCertificate> list = new ArrayList<>();
        String sql = "SELECT dc.*, u.full_name as citizen_name FROM death_certificates dc JOIN users u ON dc.citizen_id=u.id WHERE dc.citizen_id=? ORDER BY dc.applied_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, citizenId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapDC(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<DeathCertificate> getAll() {
        List<DeathCertificate> list = new ArrayList<>();
        String sql = "SELECT dc.*, u.full_name as citizen_name FROM death_certificates dc JOIN users u ON dc.citizen_id=u.id ORDER BY dc.applied_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapDC(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public DeathCertificate getById(int id) {
        String sql = "SELECT dc.*, u.full_name as citizen_name FROM death_certificates dc JOIN users u ON dc.citizen_id=u.id WHERE dc.id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapDC(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean updateStatus(int id, String status, String remarks) {
        String sql = "UPDATE death_certificates SET status=?, admin_remarks=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, remarks);
            ps.setInt(3, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public int countByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM death_certificates WHERE status=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    private DeathCertificate mapDC(ResultSet rs) throws SQLException {
        DeathCertificate dc = new DeathCertificate();
        dc.setId(rs.getInt("id"));
        dc.setCitizenId(rs.getInt("citizen_id"));
        dc.setCitizenName(rs.getString("citizen_name"));
        dc.setDeceasedName(rs.getString("deceased_name"));
        dc.setDateOfDeath(rs.getDate("date_of_death"));
        dc.setPlaceOfDeath(rs.getString("place_of_death"));
        dc.setCauseOfDeath(rs.getString("cause_of_death"));
        dc.setAgeAtDeath(rs.getInt("age_at_death"));
        dc.setRelationWithApplicant(rs.getString("relation_with_applicant"));
        dc.setAddress(rs.getString("address"));
        dc.setStatus(rs.getString("status"));
        dc.setAdminRemarks(rs.getString("admin_remarks"));
        dc.setAppliedDate(rs.getTimestamp("applied_date"));
        dc.setUpdatedDate(rs.getTimestamp("updated_date"));
        return dc;
    }
}
