package com.gp.dao;

import com.gp.model.Complaint;
import com.gp.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ComplaintDAO {

    public boolean file(Complaint c) {
        String sql = "INSERT INTO complaints (citizen_id, category, subject, description, location) VALUES (?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, c.getCitizenId());
            ps.setString(2, c.getCategory());
            ps.setString(3, c.getSubject());
            ps.setString(4, c.getDescription());
            ps.setString(5, c.getLocation());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public List<Complaint> getByCitizenId(int citizenId) {
        List<Complaint> list = new ArrayList<>();
        String sql = "SELECT c.*, u.full_name as citizen_name FROM complaints c JOIN users u ON c.citizen_id=u.id WHERE c.citizen_id=? ORDER BY c.filed_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, citizenId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapComplaint(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<Complaint> getAll() {
        List<Complaint> list = new ArrayList<>();
        String sql = "SELECT c.*, u.full_name as citizen_name FROM complaints c JOIN users u ON c.citizen_id=u.id ORDER BY c.filed_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapComplaint(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<Complaint> getByStatus(String status) {
        List<Complaint> list = new ArrayList<>();
        String sql = "SELECT c.*, u.full_name as citizen_name FROM complaints c JOIN users u ON c.citizen_id=u.id WHERE c.status=? ORDER BY c.filed_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapComplaint(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Complaint getById(int id) {
        String sql = "SELECT c.*, u.full_name as citizen_name FROM complaints c JOIN users u ON c.citizen_id=u.id WHERE c.id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapComplaint(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean updateStatus(int id, String status, String remarks) {
        String sql = "UPDATE complaints SET status=?, admin_remarks=? WHERE id=?";
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
        String sql = "SELECT COUNT(*) FROM complaints WHERE status=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    private Complaint mapComplaint(ResultSet rs) throws SQLException {
        Complaint c = new Complaint();
        c.setId(rs.getInt("id"));
        c.setCitizenId(rs.getInt("citizen_id"));
        c.setCitizenName(rs.getString("citizen_name"));
        c.setCategory(rs.getString("category"));
        c.setSubject(rs.getString("subject"));
        c.setDescription(rs.getString("description"));
        c.setLocation(rs.getString("location"));
        c.setStatus(rs.getString("status"));
        c.setAdminRemarks(rs.getString("admin_remarks"));
        c.setFiledDate(rs.getTimestamp("filed_date"));
        c.setUpdatedDate(rs.getTimestamp("updated_date"));
        return c;
    }
}
